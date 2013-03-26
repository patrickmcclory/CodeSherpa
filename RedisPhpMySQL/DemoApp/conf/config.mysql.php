<?php
$mysqlServer  = "localhost";
$mysqluserName = "dbUser";
$mysqlPassword = "P@ssword1";
$mysqlDBName = "flightStats"

$mysqlQuery = "select CARRIER, count(*) from ontimeData group by CARRIER;";
?>