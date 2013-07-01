<?=_v('header.tpl')?>
<div class="adminbody">
	<div class="post-content">
		<h3>添加新仓库</h3>
		<form action="<?=B?>/project/repo_form/<?=$id?>" method="post">
		<div class="control-group <?if(form_error('title')) echo 'error';?>">
			<label>仓库名称</label>
			<input type="text" name="title" value="<?if( isset($repo)) echo $repo->title;?>" id="title" />
			<?php echo form_error('title')?>
		</div>

		<div class="control-group <?if(form_error('title')) echo 'error';?>">
			<label>业务/组件名称</label>
			<input type="text" name="yewu_title" value="<?if( isset($repo)) echo $repo->yewu_title;?>" id="yewu_title" />
			<?php echo form_error('yewu_title')?>
		</div>

		<div class="control-group <?if(form_error('address')) echo 'error';?>">
			<label>仓库地址<span style="font-size:11px;color:gray;">链接请用英文[ ]：[http://f2e.dp/face]</span></label>
			<input type="text" name="address" value="<?if( isset($repo)) echo $repo->address;?>" id="address" />
			<?php echo form_error('address')?>
		</div>

		<div class="control-group <?if(form_error('memo')) echo 'error';?>">
			<label>仓库描述</label>
			<textarea rows="3" class="input-xxlarge" name="memo"><?if( isset($repo)) echo $repo->memo;?></textarea>
			<?php echo form_error('memo')?>
		</div>

		<input type="submit" class="btn" name="__storm__" value="提交" />
		</form>

	</div>
</div>

<?=_v('footer.tpl')?>