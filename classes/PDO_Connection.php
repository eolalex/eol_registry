<?php
require_once '../vendor/php-activerecord/ActiveRecord.php';
require_once "Horde/Yaml.php";
require_once "Horde/Yaml/Loader.php";
require_once "Horde/Yaml/Node.php";
 
/* Default Environment */
if(!isset($GLOBALS['ENV_NAME'])) $GLOBALS['ENV_NAME'] = 'development';
 
ActiveRecord\Config::initialize(function($cfg)
{             
    $cfg->set_model_directory(__DIR__.'/../models');
    $environments           = Horde_Yaml::loadFile('../config/database.yml');           
    $MYSQL_SERVER           = $environments[$GLOBALS['ENV_NAME']]['host'];
    $MYSQL_USER             = $environments[$GLOBALS['ENV_NAME']]['username'];
    $MYSQL_PASSWORD         = $environments[$GLOBALS['ENV_NAME']]['password'];
    $MYSQL_DATABASE         = $environments[$GLOBALS['ENV_NAME']]['database'];
    $con_string             = 'mysql://'.$MYSQL_USER.':'.$MYSQL_PASSWORD.'@'.$MYSQL_SERVER.'/'. $MYSQL_DATABASE;
    $cfg->set_connections(array($GLOBALS['ENV_NAME'] => $con_string));
});


?>