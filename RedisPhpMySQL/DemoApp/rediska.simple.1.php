<?php

require_once "conf/config.rediska.php";
require_once "Rediska/Key.php";

$key = new Rediska_Key('firstname');
$key->setValue('patrick');
echo $key->getValue();

?>