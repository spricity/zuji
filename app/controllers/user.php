<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class User extends CI_Controller {

	public function login(){
		if($_POST){
			$uname = _p('uname');
			$password = _p('pwd');
			if(!$uname || !$password){
				_sess('error', '每一项都必填');
			}else{
				$password = md5($password);
				$user = _db()->query("select * from user where `uname` = '$uname' and `password` = '$password'")->row();
				if($user){
					if($user->active == 0){
						_sess('error', '您的账号还没有被激活，请联系崎轩进行激活！');
					}else{
						$this->session->set_userdata('uid', $user->id);
						$this->session->set_userdata('uname', $user->uname);
						$this->session->set_userdata('email', $user->email);
						$this->session->set_userdata('roles', $user->level);
						$go= _p('go' , B);
						redirect($go);
					}
				}else{
					_sess('error', '用户名和密码不正确！');
				}
			}
		}
		$data['go'] = _g('go', B);
		$data['success'] = _sess('success');
		$data['error'] = _sess('error');
		_v('user/login.tpl', $data);
	}

	public function register(){
		if($_POST){
			$uname = _p('uname');
			$password = _p('pwd');
			$email = _p('email');
			if(!$uname || !$password || !$email){
				_sess('error', '每一项都必填');
			}else{
				$db['uname'] = $uname;
				$db['email'] = $email;
				$db['password'] = md5($password);
				$db['time'] = now();
				$db['active'] = 0;
				$user = _db()->query("select * from user where `uname` = '$uname' or `email` = '$email'");
				if($user->num_rows() > 0){
					_sess('error','用户名或者邮箱已经存在');
				}elseif(_db()->insert('user', $db)){
					$uid = _db()->insert_id();
					_sess('success', '注册成功，请通知崎轩审核通过');
					redirect(B);
				}else{
					_sess('error', '注册失败');
				}
			}
		}
		$data['success'] = _sess('success');
		$data['error'] = _sess('error');
		_v('user/register.tpl', $data);
	}

	public function logout(){
		$this->session->sess_destroy();

		redirect(B);
	}

	public function manage(){
		go_login();
		if(face_admin()){
			$users = _db()->query("select * from user")->result();

			$data['users'] = $users;
			$data['success'] = _sess('success');
			$data['error'] = _sess('error');
			_v('user/list.tpl', $data);
		}else{
			redirect(B);
		}
	}
	public function active(){
		go_login();
		if(!face_admin()){
			redirect(B);
		}

		$uid = _seg(3);
		$db['active'] = 1;
		_db()->where('id', $uid);
		if(_db()->update('user', $db)){
			_sess('success', '修改成功');
		}else{
			_sess('error', '修改失败');
		}
		redirect('/user/manage');
	}
	public function noactive(){
		go_login();
		if(!face_admin()){
			redirect(B);
		}

		$uid = _seg(3);
		$db['active'] = 0;
		_db()->where('id', $uid);
		if(_db()->update('user', $db)){
			_sess('success', '修改成功');
		}else{
			_sess('error', '修改失败');
		}
		redirect('/user/manage');
	}

	public function edit(){
		go_login();
		if(!face_admin()){
			redirect(B);
		}

		if($_POST){
			$db['uname'] = _p('uname');
			$db['email'] = _p('email');
			$db['level'] = _p('level');
			$uid = _p('uid');
			_db()->where('id', $uid);
			if(_db()->update('user', $db)){
				_sess('success', '修改成功');
				redirect(B . '/user/manage');
			}else{
				_sess('error', '修改失败');
				redirect(B . '/user/manage');
			}
		}else{
			$uid = _seg(3);
			if(!$uid){
				_sess('error', '用户不存在');
				redirect(B . '/user/manage');
			}
			$user = _db()->query("select * from user where `id` = $uid")->row();
			if(!$user){
				_sess('error', '用户不存在');
				redirect(B . '/user/manage');
			}else{
				$data['user'] = $user;
				_v('user/edit.tpl', $data);
			}
		}

	}
}