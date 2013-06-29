<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Auth {
	private $ci;
	function __construct()
	{
		$this->ci =& get_instance();
	}

	public function __get($name){
		$name = strtolower($name);
		switch($name){
			case 'islogin':
				//Check if user login in.
				// if status = 1, the user logined, and return true
				return (boolean)$this->ci->session->userdata('uid') === true;
				break;
			case 'uid':
				return $this->ci->session->userdata('uid');
				break;
			case 'uname':
				return $this->ci->session->userdata('uname');
				break;
			case 'email':
				return $this->ci->session->userdata('email');
				break;
			case 'success':
				if(isset($this->ci->session->userdata['success']) && $this->ci->session->userdata['success']){
					$success = $this->ci->session->userdata['success'];
					$this->ci->session->unset_userdata('success');
					return $success;
				}
				return false;
				break;
			case 'error':
				if(isset($this->ci->session->userdata['error']) && $this->ci->session->userdata['error']){
					$success = $this->ci->session->userdata['error'];
					$this->ci->session->unset_userdata('error');
					return $success;
				}
				return false;
				break;
			default:
				if(isset($this->ci->session->userdata[$name])){
					return $this->ci->session->userdata[$name];
				}
				return '';
				break;
		}
	}
}