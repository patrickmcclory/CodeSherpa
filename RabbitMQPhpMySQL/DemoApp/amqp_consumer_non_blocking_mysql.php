<?php
    
    include(__DIR__ . '/demo/config.php');
    use PhpAmqpLib\Connection\AMQPConnection;
    
    $exchange = 'router';
    $queue = 'msgs';
    $consumer_tag = 'consumer';
    
    $conn = new AMQPConnection(HOST, PORT, USER, PASS, VHOST);
    $ch = $conn->channel();
    
    /*
     The following code is the same both in the consumer and the producer.
     In this way we are sure we always have a queue to consume from and an
     exchange where to publish messages.
     */
    
    /*
     name: $queue
     passive: false
     durable: true // the queue will survive server restarts
     exclusive: false // the queue can be accessed in other channels
     auto_delete: false //the queue won't be deleted once the channel is closed.
     */
    $ch->queue_declare($queue, false, true, false, false);
    
    /*
     name: $exchange
     type: direct
     passive: false
     durable: true // the exchange will survive server restarts
     auto_delete: false //the exchange won't be deleted once the channel is closed.
     */
    
    $ch->exchange_declare($exchange, 'direct', false, true, false);
    
    $ch->queue_bind($queue, $exchange);
    
    function process_message($msg)
    {
    	require "conf/mysql.conf.php";
        $tranID = uniqid('',true); //more_entropy means more uniqueness
        
        //log message before acting so we can roll back if daemon dies during execution
        echo "\n--------\n";
        echo "starttranid: $tranID:\n";
        echo $msg->body;
        echo "\n--------\n";
        
        $msg->delivery_info['channel']->
        basic_ack($msg->delivery_info['delivery_tag']);
        
        // Send a message with the string "quit" to cancel the consumer.
        if ($msg->body === 'quit') {
            $msg->delivery_info['channel']->
            basic_cancel($msg->delivery_info['consumer_tag']);
        }
        else {
            
            $conn = mysqli_connect($mysqlServer, $mysqlUserName, $mysqlPassword, $mysqlDBName);
            $result = mysqli_query($conn,$msg->body);
            
            echo "\n--------\n";
            echo "endtranid: $tranID|$result|COMPLETE\n";
            echo "\n--------\n";
            
            mysqli_close($conn);
        }
    }
    
    /*
     queue: Queue from where to get the messages
     consumer_tag: Consumer identifier
     no_local: Don't receive messages published by this consumer.
     no_ack: Tells the server if the consumer will acknowledge the messages.
     exclusive: Request exclusive consumer access, meaning only this consumer can access the queue
     nowait:
     callback: A PHP Callback
     */
    
    $ch->basic_consume($queue, $consumer_tag, false, false, true, false, 'process_message');
    
    function shutdown($ch, $conn)
    {
        $ch->close();
        $conn->close();
    }
    register_shutdown_function('shutdown', $ch, $conn);
    
    // Loop as long as the channel has callbacks registered
    while (count($ch->callbacks)) {
        $read   = array($conn->getSocket()); // add here other sockets that you need to attend
        $write  = null;
        $except = null;
        if (false === ($num_changed_streams = stream_select($read, $write, $except, 60))) {
            /* Error handling */
        } elseif ($num_changed_streams > 0) {
            $ch->wait();
        }
    }