<?php
require_once '../classes/PDO_Connection.php';

echo('creating initial empty push ...<br>');
$push_request = new PushRequest;
$push_request -> site_id = 1;
$push_request -> file_url = '';
$push_request -> file_md5_hash = '';
$push_request -> received_at = date("Y-m-d H:i:s");
$push_request -> success_at = date("Y-m-d H:i:s");
$push_request -> success = 1;

$push_request -> save();

echo('done<br>');
echo('uuid: '.$push_request->uuid.'<br>');

echo('updating all sites with initial uuid ... <br>');

$push_request->connection()->query("update sites set current_uuid='".$push_request->uuid."';" );

echo('done<br>');

?>