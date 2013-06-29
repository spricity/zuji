<?php

//时间格式化函数
function f_date($date){
	return date('m-d',strtotime($date) );
}
function now(){
	return date('Y-m-d H:i:s');
}

function diff_date($d){
	return date('m-d H:i', strtotime($d));
}
/**
 * json
 *
 * @param mixed $flag
 * @param mixed $info
 * @param mixed $database
 * @param mixed $argu1
 * @param mixed $argu2
 * @return void
 */
 if(!function_exists('json')){
	function json($status = null, $tips = null,$url='/'){
			$result['code']         = $status;
			$result['msg'] 		= $tips;
			$r = isset($_SERVER['HTTP_X_REQUESTED_WITH']) ? strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) : '';
			$inAjax = $r == 'xmlhttprequest';
			if($inAjax){
				echo (json_encode( $result ));exit;
			}else{
				if($status){
					_sess('success', $tips);
				}else{
					_sess('error', $tips);
				}
				header("Location:$url");exit;
			}
	}
 }
 if(!function_exists('dbg')){
	function dbg($data='',$f=false){
	echo '<pre>';
	print_r($data);
	if(!$f)
	exit;
}
 }


//当前的URL
function getHeader(){
	$host = 'http://'.$_SERVER['HTTP_HOST'];
	//$host = str_replace("localhost","127.0.0.1",$host);
	return $host;
}

/******************************************************************
* PHP截取UTF-8字符串，解决半字符问题。
* 英文、数字（半角）为1字节（8位），中文（全角）为3字节
* @return 取出的字符串, 当$len小于等于0时, 会返回整个字符串
* @param $str 源字符串
* $len 左边的子串的长度
****************************************************************/

if( !function_exists('character_limiter')){
	function character_limiter($str='',$len='100',$dot = '...'){
		if(!$str) return '';
		$str = strip_tags( htmlspecialchars_decode($str) );
		for($i=0;$i<$len;$i++){
			$temp_str=substr($str,0,1);
			if(ord($temp_str) > 127){
				$i++;
				if($i<$len){
					$new_str[]=substr($str,0,3);
					$str=substr($str,3);
				}
			}else{
				$new_str[]=substr($str,0,1);
				$str=substr($str,1);
			}
		}
		return join($new_str);
	}

}

if( !function_exists('_g')){
	function _g($param, $default=''){
		$ci = & get_instance();
		return (!$ci->input->get($param)) ? $default : htmlspecialchars($ci->input->get($param), ENT_QUOTES);
	}
}

if( !function_exists('_p')){
	function _p($param, $default=''){
		$ci = & get_instance();
		return (!$ci->input->post($param)) ? $default : htmlspecialchars($ci->input->post($param), ENT_QUOTES);
	}
}

//uri->segment
if( !function_exists('_seg')){
	function _seg($id){
		$ci = & get_instance();
		return $ci->uri->segment($id);
	}
}


//database
if( !function_exists('_db')){
	function _db(){
		$ci = & get_instance();
		return $ci->db;
	}
}

//session
if( !function_exists('_sess')){
	function _sess($key,$value = ''){
		$ci = & get_instance();
		if($value){
			$ci->session->set_userdata($key, $value);
		}else{
			$value = $ci->session->userdata($key);
			$ci->session->unset_userdata($key);
			return $value;
		}
	}
}

//Auth
if( !function_exists('_u')){
	function _u($key, $default = ''){
		$ci = & get_instance();
		if($ci->auth->$key)
			return $ci->auth->$key;
		else
			return $default;
	}
}
//View
if( !function_exists('_v')){
	function _v($template,$paramers = array()){
		$ci = & get_instance();
		return $ci->load->view($template,$paramers);
	}
}

//Language
if( !function_exists('_lang')){
	function _lang($key){
		$ci = & get_instance();
		return $ci->lang->line($key);
	}
}
if( !function_exists('login_url')){
	function login_url(){
		return B . '/user/login?go=' . B . $_SERVER['REQUEST_URI'];
	}
}

if( !function_exists('go_login')){
	function go_login(){

		if(!is_login()){
			redirect(login_url());
		}
	}
}

if( !function_exists('is_self')){
	function is_self($uid){
		return _u('uid') == $uid;
	}
}
if( !function_exists('is_login')){
	function is_login(){
		$ci = & get_instance();
		return $ci->auth->islogin;
	}
}

if( !function_exists('face_admin')){
	function face_admin(){
		$ci = & get_instance();

		if(!is_login())
		{
			return false;
		}

		$user_level = $ci->session->userdata('roles');
		if($user_level == 10){
			return true;
		}
		return false;
	}
}


if( !function_exists('fastcgi_finish_request')){
	function fastcgi_finish_request(){;}
}
if(!function_exists('get_avatar')){
	function get_avatar($email = ''){
		//return 'http://www.gravatar.com/avatar/' . md5(strtolower($email)) . '?s=60&d=&r=G';
		return B . '/carine/www/image/user_avatar.png';
	}
}

if ( ! function_exists('redirect'))
{
	/**
	 * Header Redirect
	 *
	 * Header redirect in two flavors
	 * For very fine grained control over headers, you could use the Output
	 * Library's set_header() function.
	 *
	 * @param	string	the URL
	 * @param	string	the method: location or refresh
	 * @param	int
	 * @return	string
	 */
	function redirect($uri = '', $method = 'auto', $code = NULL)
	{
		if ( ! preg_match('#^https?://#i', $uri))
		{
			$uri = site_url($uri);
		}

		// IIS environment likely? Use 'refresh' for better compatibility
		if (DIRECTORY_SEPARATOR !== '/' && $method === 'auto')
		{
			$method = 'refresh';
		}
		elseif ($method !== 'refresh' && (empty($code) OR ! is_numeric($code)))
		{
			// Reference: http://en.wikipedia.org/wiki/Post/Redirect/Get
			$code = (isset($_SERVER['REQUEST_METHOD'], $_SERVER['SERVER_PROTOCOL'])
					&& $_SERVER['REQUEST_METHOD'] === 'POST'
					&& $_SERVER['SERVER_PROTOCOL'] === 'HTTP/1.1')
				? 303 : 302;
		}

		switch ($method)
		{
			case 'refresh':
				header('Refresh:0;url='.$uri);
				break;
			default:
				header('Location: '.$uri, TRUE, $code);
				break;
		}
		exit;
	}
}
if ( ! function_exists('uplod'))
{
	function upload($file){
		if($file['error'] == 0){
			$size = round($file['size'] / 1024 / 1024, 1);
			if($file['size'] / 1024 > 10240){
				return array(false, '上传文件不能大于5M，您的上传文件是' . $size . 'M');
			}
			$day = date('Ym', time());
			$upload_path = BASEDIR . DS . 'uploads' . DS . $day;
			if(!is_dir($upload_path)){
				mkdir($upload_path, '0755' , true);
			}
			@move_uploaded_file($file['tmp_name'], $upload_path . DS . $file['name']);
			return array(true,'/uploads/' . $day . '/' . $file['name']);
		}
		return array(false, 'IO错误，请重新选择文件');

	}
}

if ( ! function_exists('show_message'))
{
	function show_message($message)
	{
		_v('errors/message', array('message' => $message));
	}

}


function getUploadName($path){
	$x = explode('.', $path);
	$ext = end($x);
	$n = explode('/', $path);
	$name = end($n);
	return $name;
}

function get_claim_category($category){
	switch ($category) {
		case 'F2E':
			return '前端技术(JS\CSS\HTML)';
			break;
		case 'UED':
			return 'UED(UE、UD)';
			break;
		case 'PHP':
			return '后端技术(JAVA\PHP\IOS\Android\C++)';
			break;
		case 'SERVER':
			return '服务器(Linux)';
			break;
		case 'DESIGN':
			return '设计(PS\AI)';
			break;

		default:
			return '其他';
			break;
	}
}
