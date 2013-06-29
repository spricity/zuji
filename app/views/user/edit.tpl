<?=_v('header.tpl')?>
<div class="adminbody">
	<section id="main">

		<form class="well" action="<?=B?>/user/edit" method="post" enctype="multipart/form-data">
			<div class="control-group <?if(form_error('uname')) echo 'error';?>">
				<label>用户名</label>
				<input type="text" class="span3" name="uname" value="<?=set_value('uname', isset($user) ? $user->uname : '')?>" placeholder="">
				<?php echo form_error('uname')?>
			</div>

			<div class="control-group <?if(form_error('email')) echo 'error';?>">
				<label>邮箱</label>
				<input type="text" class="span3" name="email" value="<?=set_value('email', isset($user) ? $user->email : '')?>" placeholder="">
				<?php echo form_error('email')?>
			</div>

			<div class="control-group <?if(form_error('level')) echo 'error';?>">
				<label>级别</label>
				<input type="text" class="span3" name="level" value="<?=set_value('level', isset($user) ? $user->level : '')?>" placeholder="">
				<?php echo form_error('level')?>
			</div>


			<input type="hidden" name="uid" value="<?=$user->id?>" />
			<input type="submit" class="btn" name="__claim__" value="提交" />
		</form>
	</section>
</div>
<?=_v('footer.tpl')?>