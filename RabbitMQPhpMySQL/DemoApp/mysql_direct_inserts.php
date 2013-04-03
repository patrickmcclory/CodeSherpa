<?PHP
    require_once(datagenerator.php);
    require_once "conf/config.mysql.php";
    
    $conn = mysql_connect($mysqlServer, $mysqlUserName, $mysqlPassword);
    mysql_select_db($mysqlDBName);
    $result = mysql_query($insertStatement);
    mysql_free_result($result);
    mysql_close($conn);
    echo "MYSQL Result: $result";
?>