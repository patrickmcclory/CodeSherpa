<?PHP
    require_once "datagenerator.php";
    require_once "conf/mysql.conf.php";
    
    echo "Insert Statement is: $insertStatement";
    
    $conn = mysqli_connect($mysqlServer, $mysqlUserName, $mysqlPassword, $mysqlDBName);
    $result = mysqli_query($conn,$insertStatement);

    echo "MYSQL Result: $result";
        mysqli_close($conn);
?>