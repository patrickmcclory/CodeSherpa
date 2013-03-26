<?php
require_once 'Rediska.php'

$rediskaConfig = array(
	'namespace' => 'DemoTestApp',
	'servers' => array(
		array('host' => '127.0.0.1', 'port' => 6379)
	)
);

$rediska = new Rediska($rediskaConfig);

?>