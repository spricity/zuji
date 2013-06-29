<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


class Version extends CI_Controller {

	public function index(){
		$data['version'] = _db()->query('select * from version order by time desc')->result();
		$data['repo'] = _db()->query("select * from repo")->result_id();
		$data['user'] = _db()->query("select * from user")->result_id();
		$data['repo_id'] = 0;
		_v('version/list.tpl', $data);
	}

	public function display(){
		$repo_id = (int)_seg(3);
		if(!$repo_id) redirect( B . '/version');

		$data['version'] = _db()->query("select * from version_history where repo_id = $repo_id order by time desc")->result();
		$data['repo'] = _db()->query("select * from repo")->result_id();
		$data['user'] = _db()->query("select * from user")->result_id();
		$data['repo_id'] = $repo_id;
		_v('version/list.tpl', $data);
	}

	public function add_version(){
		go_login();
		$id = (int)_seg(3);
		if($_POST){
			$this->form_validation->set_error_delimiters('<span class="help-inline">','</span>');
			$this->form_validation->set_rules('title','项目名称','trim|required');
			$this->form_validation->set_rules('repo','仓库','trim|required');
			$this->form_validation->set_rules('memo','仓库描述','trim|required');
			$flag = false;
			if($this->form_validation->run() == false){
				$errors = validation_errors();
				$flag = true;
				_sess('error', $errors);
			}else{
				$errors = false;
				$title = set_value('title');
				$repo_id = set_value('repo');
				$repo = _db()->query("select * from repo where id = " . $repo_id)->row();
				if(!$repo){
					_sess('error', 'repo已经被删除');
					$flag = false;
				}else{
					$db = array(
						'title' => $title,
						'repo_id' => $repo->id,
						'repo_name' => $repo->title,
						'memo' => set_value('memo'),
					);


						$db['uid']	=	_u('uid');
						$db['time'] = now();
						$lastVersion = _db()->query("select * from version where `repo_id` = '$repo_id' order by version desc")->row();
						if($lastVersion){
							$version = $lastVersion->version;
							$newVersion = $this->getNewVersion($version);
							$db['version'] = $newVersion;
							_db()->where('id', $lastVersion->id);
							if(_db()->update('version' , $db)){
								_sess('success' , '操作成功');
							}else{
								$flag = true;
								_sess('error' , '操作失败');
							}
						}else{
							$db['version'] = '1.0.0';
							if(_db()->insert('version', $db)){
								_sess('success' , '操作成功');
								$id = _db()->insert_id();
							}else{
								$flag = true;
								_sess('error' , '操作失败');
							}
						}
						if(!$flag){
							_db()->insert('version_history', $db);
						}
				}
				if(!$flag) { // 操作成功
					redirect(B . '/project/repo');
				}
			}
		}
		$data['id'] = $id;

		$data['repo'] = _db()->query("select * from repo order by time desc")->result();
		$data['success'] = _sess('success');
		$data['error'] = _sess('error');
		_v('version/form.tpl', $data);
	}

	private function getNewVersion($version){
		// $version = '1.99.99';
		$versions = explode('.', $version);
		$versions[0] = (int)$versions[0];
		$versions[1] = (int)$versions[1];
		$versions[2] = (int)$versions[2];
		if($versions[2] < 99){
			$versions[2] = $versions[2] + 1;
		}elseif($versions[1] < 99){
			$versions[1] = $versions[1] + 1;
			$versions[2] = 0;
		}elseif($versions[0] < 99){
			$versions[0] = $versions[0] + 1;
			$versions[1] = 0;
			$versions[2] = 0;
		}
		return implode('.', $versions);
	}
}