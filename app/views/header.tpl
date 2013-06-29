<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>聚划算-足迹系统</title>
	<link rel="stylesheet" href="<?=B?>/www/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<?=B?>/www/index.css">
	<script type="text/javascript" src="<?=B?>/www/jquery.js"></script>
<head>
<body>
<body>
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
		<a href="<?=B?>" class="brand">首页</a>
		<ul class="nav" id="navTab" style="width: 90%;">
		  <li id="navrepo" <?if(strpos($_SERVER['REQUEST_URI'], 'repo')):?>class="active"<?endif?> >
			<a href="<?=B?>/project/repo">仓库</a>
		  </li>
		  <li id="navversion" <?if(strpos($_SERVER['REQUEST_URI'], 'version')):?>class="active"<?endif?> >
			<a href="<?=B?>/version">版本</a>
		  </li>
		  <?if(face_admin()):?>
		  	<li <?if(strpos($_SERVER['REQUEST_URI'], 'user')):?>class="active"<?endif?>><a href="/user/manage">用户</a></li>
		  <?endif?>
		  <?if(_u('islogin')):?>
			  <li style="float:right;"><a href="/user/logout">退出</a></li>
			  <li style="float:right;">
			  	<a href="javascript:;">当前登录：<?=_u('uname')?></a>
			  </li>
		  <?else:?>
		  	<li style="float:right;"><a href="/user/register">注册</a></li>
		  	<li style="float:right;"><a href="/user/login">登录</a></li>
		  <?endif?>
		</ul>
    </div>
  </div>
</div>