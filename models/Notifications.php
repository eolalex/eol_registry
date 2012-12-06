<?php

class Notifications 
{
	static function error_message_to_json($error_message)
	{
		$arr = array('success' => 0, 'message' => $error_message);
		return json_encode($arr);		
	} 
	
	static function send_processing_to_node($uuid)
	{
		$arr = array('success' => 1, 'message' => 'Processing', 'uuid' => $uuid);
		return json_encode($arr);		
	}
} 