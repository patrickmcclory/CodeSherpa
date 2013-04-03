## RabbitMQ, PHP and MySQL

To be honest, there's not much I can add to the cannonical literature found out on the web related to these technologies on their own.  I'm going to rely heavily on a number of excellent resources that simply do a better job than I can at providing code samples, configurations and information related to the way these technologies can work together.  I have,  however, addded another layer (daemontools-run) and build out a very simple db insert listener using PHP.  This isn't at all intended to be a best practice application, but to explore the concepts held within the solution(s) at play.  Here's what I've found helpful:

### The Basics

Let's get the easy stuff out of the way--if you're looking for what the heck this is, check out the [Wikipedia]9http://en.wikipedia.org/wiki/Message_queue) article on message queues--it does a significantly better job than I can in a short period of time of explaining what it does.  Since we're working with RabbitMQ, which implementes Advanced Message Queueing Protocol, it might be worthwhile to understand the internals of it as well by [checking out the article on that](http://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol) too.

Specific to RabbitMQ, again, [Wikipedia](http://en.wikipedia.org/wiki/RabbitMQ) does a good job of getting a high-level overview of the solution while [RabbitMQ's site](http://www.rabbitmq.com) does an excellent job of getting all of the details in place related to everything from usage to advanced configuration.  Specifically notable are:

 * [RabbitMQ - Getting Started](http://www.rabbitmq.com/getstarted.html)
 * [RabbitMQ - Documentation](http://www.rabbitmq.com/documentation.html)
 * [AMQP 0-9-1 Quick Reference](http://www.rabbitmq.com/amqp-0-9-1-quickref.html)

### RabbitMQ information

There's a great set of information on RabbitMQ at [their site](http://www.rabbitmq.com) and a ton of articles all over the internet.  The examples I'm working with utilize the following:

 * [php-amqplib](https://github.com/videlalvaro/php-amqplib) - a pure PHP implementation of the AMQP protocol with examples
 * [rabbitmq-server 2.8.4](http://www.rabbitmq.com/install-debian.html) - the default apt package for Ubuntu 12.10
 * [Composer](http://getcomposer.org) - Dependency Manager for PHP
 * and, to a lesser degree, [rabbitmq's rabbitmq-tutorials](https://github.com/rabbitmq/rabbitmq-tutorials) repo
 
### Daemontools information

In trying to limit the number of technologies being used, I decided to use Daemontools to run and host a php script as a service to listen to a queue and do 'something' with the data.  I picked this specifically for the persistence and logging features, knowing full-well that I'd much rather write a more robust service or daemon myself in java or c.  Knowing that, I took [non-blocking PHP example](https://github.com/videlalvaro/php-amqplib/blob/master/demo/amqp_consumer_non_blocking.php) provided by [Alvaro Videla](https://github.com/videlalvaro) and swapped out what it was 'doing' with a very simple mysql_query call.  Again--not rocket science here, but demonstrating the concept.  This all gets wrapped into a daemontools-hosted process that kicks logs out from the console as well.  


### A bunch of other stuff...

