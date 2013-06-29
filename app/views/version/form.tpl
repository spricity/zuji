<?=_v('header.tpl')?>
<div class="adminbody">
	<section id="main">

		<form class="well" action="<?=B?>/project/add_version/<?=$id?>" method="post" enctype="multipart/form-data">
			<div class="control-group <?if(form_error('title')) echo 'error';?>">
				<label>项目名称</label>
				<input type="text" class="span3" name="title" value="" placeholder="">
				<?php echo form_error('title')?>
			</div>

			<div class="control-group <?if(form_error('repo')) echo 'error';?>">
				<label class="control-label">repo</label>
				<div class="controls">
					<select name="repo" >
						<?foreach($repo as $r):?>
						<option value="<?=$r->id?>" <?if( $id == $r->id) echo 'selected="selected"';?>><?=$r->title?></option>
						<?endforeach?>
					</select>
					<?php echo form_error('repo')?>
				</div>
			</div>

			<div class="control-group <?if(form_error('memo')) echo 'error';?>">
				<label class="control-label">项目描述</label>
				<div class="controls">
					<textarea class="input-mmlarge" id="textarea" name="memo" rows="3" placeholder=""></textarea>
					<?php echo form_error('memo')?>
				</div>
			</div>


			<input type="submit" class="btn" name="__claim__" value="提交" />
		</form>
	</section>
</div>
<?=_v('footer.tpl')?>