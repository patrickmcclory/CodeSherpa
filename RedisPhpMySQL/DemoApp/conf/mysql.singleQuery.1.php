<?php

require_once "conf/config.mysql.php";

$conn=mysql_connect($mysqlServer, $mysqlUserName, $mysqlPassword, $mysqlDBName);

if(mysqli_connect_errno())
{
	echo "failed to connect to mysql: " . mysqli_connect_error();
}

$result = mysql_query($conn, $mysqlQuery);

if(mysql_num_rows($result) > 0)
{
	echo"<table cellpadding=10 border=1>";
	
	while($row = mysql_fetch_row($result))
	{
		echo"<tr>";
		
		for ($i=1; $i<=count($row); $i++)
		{
			echo "<td>";
			echo $row[$i];
			echo "</td>";	
		}
		
		echo "</tr>";
	}
	
	echo"</table>";
}

mysql_free_result($result);

mysql_close($conn);

?>