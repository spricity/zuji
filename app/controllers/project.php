<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Project extends CI_Controller {

	public function index(){
		$this->repo();
	}

	public function repo(){
		$data['repo'] = $repo = _db()->query("select * from repo order by time desc")->result();
		foreach($repo as $r){
			$repo_id[] = $r->id;
			$user_id[] = $r->uid;
		}

		$repo_id = implode(',', $repo_id);
		$user_id = implode(',', $user_id);
		$version = _db()->query("select repo_id,uid,version,title,memo,time from version where `repo_id` in ($repo_id)")->result_id();
		$user = _db()->query("select * from user where `id` in ($user_id)")->result_id();
		$data['version'] = $version;
		$data['user'] = $user;
		$data['success'] = _sess('success');
		$data['error'] = _sess('error');
		_v('project/repo.tpl', $data);

	}

	public function repo_form(){
		go_login();

		$id = (int)_seg(3);
		if($_POST){
			$this->form_validation->set_error_delimiters('<span class="help-inline">','</span>');
			$this->form_validation->set_rules('title','仓库名称','trim|required');
			$this->form_validation->set_rules('address','仓库地址','trim|required');
			$this->form_validation->set_rules('yewu_title','业务/组件名称','trim|required');
			$this->form_validation->set_rules('memo','仓库描述','trim|required');
			$flag = false;
			if($this->form_validation->run() == false){
				$errors = validation_errors();
				$flag = true;
				_sess('error', $errors);
			}else{
				$errors = false;
				$title = set_value('title');
				$db = array(
					'title' => $title,
					'address' => set_value('address'),
					'yewu_title' => set_value('yewu_title'),
					'memo' => set_value('memo'),
				);
				if($id){
					_db()->where('id', $id);
					if(_db()->update('repo', $db)){
						_sess('success' , '操作成功');
					}else{
						$flag = true;
						_sess('error' , '操作失败');
					}
				}else{
					$db['uid']	=	_u('uid');
					$db['time'] = now();
					if(_db()->query("select * from repo where `title` = '$title'")->row()){
						_sess('error', '仓库地址已经存在');
						$flag = false;
					}else{
						if(_db()->insert('repo', $db)){
							_sess('success' , '操作成功');
							$id = _db()->insert_id();
						}else{
							$flag = true;
							_sess('error' , '操作失败');
						}
					}
				}
				if(!$flag) redirect(B . '/project/repo');
			}
		}
		$data['id'] = $id;
		if($id){
			$data['repo'] =  _db()->query("select * from repo where id = $id")->row();
		}
		$data['success'] = _sess('success');
		$data['error'] = _sess('error');
		_v('project/repo_form.tpl', $data);
	}

	public function repo_del(){
		if(!face_admin()){
			go_login();
		}
		$id = (int)_seg(3);
		if(_db()->query("delete from repo where id = $id")){
			json(200, '删除成功');
		}else{
			json(201, '删除失败');
		}
	}
}