<?phprequire_once "conf/config.rediska.php";$hashSetName = "carrierFlightCount";if(($rediska->exists($hashSetName)) == false){	require_once "conf/config.mysql.php";	$conn=mysql_connect($mysqlServer, $mysqlUserName, $mysqlPassword);	mysql_select_db($mysqlDBName);	$result = mysql_query($mysqlQuery);	if(mysql_num_rows($result) > 0)	{		$countResult = new Rediska_Key_Hash($hashSetName);				while($row = mysql_fetch_row($result))		{			$countResult[$row[0]] = $row[1];		}	}	mysql_free_result($result);	mysql_close($conn);}echo"<h2>Rediska test</h2><br><br><hr><br>";echo"<table cellpadding=10 border=1>";echo"<tr><td>CarrierID</td><td>CarrierCount</td></tr>";$hashSet = new Rediska_Key_Hash($hashSetName);foreach($hashSet as $field => $value){	echo "<tr><td>".$field."</td><td>".$value."</td></tr>"}echo "</table>";?>