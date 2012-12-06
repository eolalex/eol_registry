<?php

class Site extends ActiveRecord\Model
{
	static function has_no_pending_pulls($site_id) {
		
		# get site UUID
		$site = Site::find_by_id($site_id);		
		if (!$site)
		{
			echo("Site doesn't exist");
			return false;			
		}
		
		# get received_at date for site UUID 
		$last_request_date = PushRequest::find_by_uuid($site -> current_uuid) -> received_at;
		
		echo("Last Request Date");
		echo("$last_request_date");
		
		# get successfull pushs after this date
		$pending_pushes_count = PushRequest::count('all', array('conditions' => 'success=1 and received_at>?', $last_request_date));
		
		if ($pending_pushes_count > 0)
			return false;
		else
			return true;		
	}
}

?>