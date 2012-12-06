<?php
require_once '../classes/PDO_Connection.php';

$uuid = $_GET['uuid'];


# check for all parameters
if (!$uuid )
{
		$error_message = "Missing parameters:";
		if (!$uuid) $error_message .= " 'uuid'"; 
		echo(Notifications::error_message_to_json($error_message));
		exit;
}

$push_request = PushRequest::find_by_uuid($uuid);

if (!$push_request)
	{
		$error_message = "Invalid uuid:";
		echo(Notifications::error_message_to_json($error_message));
		exit;
}

if ($push_request -> success)
{	
	if ($push_request -> success == 0)
		$arr = array('success' => $push_request -> success, 'Message' => $push_request -> failed_reason);
	else
		$arr = array('success' => $push_request -> success);
}
else
{
	$arr = array('success' => '');
}
echo(json_encode($arr));
?>