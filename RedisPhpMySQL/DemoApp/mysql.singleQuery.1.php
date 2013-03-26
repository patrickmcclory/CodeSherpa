<?php

require_once "conf/config.mysql.php";

$conn=mysql_connect($mysqlServer, $mysqlUserName, $mysqlPassword);

mysql_select_db($mysqlDBName);

$result = mysql_query($mysqlQuery);

if(mysql_num_rows($result) > 0)
{
	echo"<table cellpadding=10 border=1>";
	echo"<tr><td>CarrierID</td><td>CarrierCount</td></tr>"
		
	while($row = mysql_fetch_row($result))
	{
		echo"<tr>";
		
		for ($i=0; $i<count($row); $i++)
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