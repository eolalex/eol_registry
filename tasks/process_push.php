<?php
require_once '../classes/PDO_Connection.php';

get_pending_push();

function get_pending_push()
{
	$push_requests = PushRequest::find('all', array('conditions' => 'success is null'));
	
	if (!$push_requests)
	{
		print_r("Nothing to process\n");
	}
	else
	{
		foreach ($push_requests as $ps)
		{
			process_push($ps->id);
		}
	}
	print_r("Sleep for 10 seconds\n");
	sleep(10);
	get_pending_push();
}

function downloadFile ($url, $path) {

  $newfname = $path;
  $file = fopen ($url, "rb");
  if ($file) {
    $newf = fopen ($newfname, "wb");

    if ($newf)
    while(!feof($file)) {
      fwrite($newf, fread($file, 1024 * 8 ), 1024 * 8 );
    }
  }

  if ($file) {
    fclose($file);
  }

  if ($newf) {
    fclose($newf);
  }
 }
 
 function process_push($id)
 {
 	$push_request = PushRequest::find_by_id($id);
 	
 	print_r("Processing: ".$push_request -> uuid."\n");

	# 1. Download log file
	$file_name = "../logs/".$id.".json";
	downloadFile($push_request -> file_url, $file_name);
	
	# Downloading md5 checksum
	$md5_file_name = "../logs/".$id.".md5";
	downloadFile($push_request -> file_md5_hash, $md5_file_name);
	
	# compare checksums
	$generated_md5 = md5_file($file_name); 
	
	if ($generated_md5 != file_get_contents($md5_file_name, true))
	{
		$push_request -> failed_at = date("Y-m-d H:i:s");
		$push_request -> failed_reason = "Invalid md5 checksum";
		$push_request -> success = 0;
		$push_request -> save();
		exit();
		
		# Notify the node
		notify_node($site -> response_url);
	}	
	
	$records = json_decode(file_get_contents($file_name, true), true);
	
	foreach ($records as $key => $data)
	{
		$sync_peer_log = new SyncPeerLog;
		$sync_peer_log -> push_request_id =  $id;
		$sync_peer_log -> user_site_id = $data['user_site_id'];
		$sync_peer_log -> user_site_object_id = $data['user_site_object_id'];
		$sync_peer_log -> action_taken_at_time = $data['action_taken_at_time'];
		$sync_peer_log -> sync_object_action_id = $data['sync_object_action_id'];
		$sync_peer_log -> sync_object_type_id = $data['sync_object_type_id'];
		$sync_peer_log -> sync_object_id = $data['sync_object_id'];
		$sync_peer_log -> sync_object_site_id = $data['sync_object_site_id'];
		
		$sync_peer_log -> save();
		
		foreach ($data['parameters'] as $pkey => $pdata)
		{
			$slap = new SyncLogActionParameter;
			$slap -> peer_log_id = $sync_peer_log -> id;
			$slap -> param_object_id = $pdata['param_object_id'];
			$slap -> param_object_site_id = $pdata['param_object_site_id'];
			$slap -> parameter = $pdata['parameter'];
			$slap -> value = $pdata['value'];
			$slap -> save();
		}		
	}
	
	$push_request -> success_at = date("Y-m-d H:i:s");
	$push_request -> success = 1;
	$push_request -> save();
	
	# update uuid for this site
	$site = Site::find_by_id($push_request -> site_id);
	$site -> current_uuid = $push_request -> uuid;
	$site -> save();
	
	# Notify the node
	notify_node($site -> response_url);
	
 }
 
 function notify_node($url)
 {
	$r = new HttpRequest($site -> response_url, HttpRequest::METH_GET);
	$r->send();

	print_r("Sending notifiction to node\n");
	
   if ($r->getResponseCode() == 200) {
        print_r("Notification success, node is updating itself.\n");
    }
    else
    {
    	print_r("Notification failed, node should update itself.\n");
    }     	
 }
?>