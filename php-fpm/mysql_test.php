<?php

require("/secrets/php.conf");

$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
mysqli_select_db($connect,$dbname) or die("Could not open the db '$dbname'");

$test_query = "SHOW TABLES";
$result = mysqli_query($connect,$test_query) or die ("Could not execute query!");

$tblCnt = 0;
while($tbl = mysqli_fetch_array($result)) {
  $tblCnt++;
  echo $tbl[0]."<br />\n";
}

if (!$tblCnt) {
  echo "There are no tables<br />\n";
} else {
  echo "There are $tblCnt tables<br />\n";
}
?>
