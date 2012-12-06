<?php

class PushRequest extends ActiveRecord\Model
{
	static $before_save = array('get_new_uuid');
	
	
	public function get_new_uuid() {
		if (!$this -> uuid)
			$this -> uuid = $this->connection()->query_and_fetch_one('select uuid();');
	}	
	
	public static function locked_by_another_node()
	{
		$count = PushRequest::count(array('conditions' => 'success is null'));
		if ($count > 0)
			return true;
		else
			return false;
	}
}

?>