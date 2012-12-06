<?php

class SyncLogActionParameter extends ActiveRecord\Model 
{
	
	static $belongs_to = array (
		array('sync_peer_logs', 'foreign_key' => 'peer_log_id'),
		array('sync_object_actions'),
		array('sync_object_types')	);
		
}

?>