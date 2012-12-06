<?php

class SyncPeerLog extends ActiveRecord\Model
{
	
	static $belongs_to = array(
		array('sync_object_actions'),
		array('sync_object_types'),
		array('push_requests'));
			
	static $has_many = array(
		array('sync_log_action_parameters', 'foreign_key' => 'peer_log_id'));
		
}

?>