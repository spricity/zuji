<?=_v('header.tpl')?>
<div class="adminbody">
	<?if(is_login()):?><a href="<?=B?>/project/repo_form" class="btn btn-danger btn-action">创建repo</a><?endif?>
	<br>
	<br>
	<section id="main">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width:1%;">id</th>
					<th style="width:6%;">仓库名称</th>
					<th style="width:8%;">业务/组件名称</th>
					<th style="width:6%;">最新版本</th>
					<th style="width:6%;">最新创建者</th>
					<th style="width:8%;">最新日期</th>
					<?if(is_login()):?><th style="width:8%;">操作</th><?endif?>
				</tr>
			</thead>
			<tbody>
				<?php if($repo):?>
				<?php $i=1;foreach($repo as $dt):?>
				<tr>
					<td><?=$i?></td>
					<td><a href="<?=$dt->address?>" target="_blank"><?=$dt->title?></a></td>
					<td><?=$dt->yewu_title?></td>

					<?if(isset($version[$dt->id])):?>
						<td><?=$version[$dt->id]->version?></td>

						<?if(isset($user[$version[$dt->id]->uid])):?>
							<td><?=$user[$version[$dt->id]->uid]->uname?></td>
						<?else:?>
							<td><?=$dt->uid?></td>
						<?endif?>

						<td><?=$version[$dt->id]->time?></td>
					<?else:?>
						<td></td>

						<?if(isset($user[$dt->uid])):?>
							<td><?=$user[$dt->uid]->uname?></td>
						<?else:?>
							<td><?=$dt->uid?></td>
						<?endif?>

						<td></td>
					<?endif?>
					<?if(is_login()):?>
					<td>
						<a href="<?=B?>/project/repo_form/<?=$dt->id?>" class="btn btn-primary btn-mini">编辑</a>
						<a href="<?=B?>/version/add_version/<?=$dt->id?>" class="btn btn-primary btn-mini">版本+1</a>
						<?if(face_admin()):?>
						<a href="javascript:;" rel="<?=B?>/project/repo_del/<?=$dt->id?>" title="确认删除，不可恢复" class="J_confirm btn btn-mini">删除</a>
						<?endif?>
					</td>
					<?endif?>
				</tr>
				<?php $i++; endforeach?>
				<?php endif?>
			</tbody>
		</table>
	</section>
</div>
<script type="text/javascript">
	$(function(){
		$(".J_confirm").on("click", function(){
			var self = this;
			if(confirm(self.title)){
				$.get(self.rel, function(d){
					var j = $.parseJSON(d);
					if(j.code == 200){
						$(self).parents("tr").fadeOut();
					}else{
						alert('删除失败');
					}
				})
			}
		})
		var addrss = $("#addrss"),
			rss_value = $("#rss_value");
		addrss.on('click', function(e){

			var v = rss_value.val();
			if(v){
				$.get(F.data('BASE') + '/admin/news/addrss',{'rss': v}, function(d){
					var j = $.parseJSON(d);
					if(j.code == 200){
						window.location.reload();
					}else{
						alert(j.msg);
					}
				});
				rss_value.val('');
			}

		});
	});
</script>
<?=_v('footer.tpl')?>