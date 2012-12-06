<?php
require_once '../classes/PDO_Connection.php';

$auth_code = $_GET['auth_code'];
$current_uuid = $_GET['current_uuid'];
$file_url = $_GET['file_url'];
$file_md5_hash = $_GET['file_md5_hash'];

# check for all parameters
if (!($auth_code && $current_uuid && $file_url && $file_md5_hash))
{
		$error_message = "Missing parameters:";
		if (!$auth_code) $error_message .= " 'auth_code'";
		if (!$current_uuid) $error_message .= " 'current_uuid'"; 
		if (!$file_url) $error_message .= " 'file_url'";
		if (!$file_md5_hash) $error_message .= " 'file_md5_hash'";
		echo(Notifications::error_message_to_json($error_message));
		exit;
}

# authenticate site
$site = Site::find_by_auth_code($auth_code);
if (!$site)
{
		echo(Notifications::error_message_to_json("Invalid auth_code: ".$auth_code));
		exit;	
}

# make sure that the site and the registry have the same UUID for this site 
# TODO: if this check fails, then this node is out of sync. we need to figure out a procedure to fix this!
if ($site->current_uuid != $current_uuid)
{
		echo(Notifications::error_message_to_json("Invalid current_uuid: ".$current_uuid));
		exit;	
}

# check if the registry is processing another request.
# in the future we may remove this check as needed.

if (PushRequest::locked_by_another_node())
{
		echo(Notifications::error_message_to_json("Registry is busy"));
		exit;
}

# Now add the push request and send "Processing" to the node
$push_request = new PushRequest();
$push_request -> site_id = $site -> id;
$push_request -> file_url = $file_url;
$push_request -> file_md5_hash = $file_md5_hash;
$push_request -> received_at = date("Y-m-d H:i:s");
$push_request -> save();

echo(Notifications::send_processing_to_node($push_request -> uuid));

#$r = new HttpRequest('process_push.php', HttpRequest::METH_GET);
#$r->addQueryData(array('id' => $push_request -> id));
#$r->send();

?>