<?=_v('header.tpl')?>
<div class="adminbody">
	<ul class="nav nav-pills">
	<?foreach($repo as $r):?>
		<li <?if($r->id == $repo_id):?>class="active"<?endif?>><a href="<?=B . '/version/display/' . $r->id ?>"><?=$r->title?></a></li>
	<?endforeach?>
	</ul>
	<br>
	<br>
	<section id="main">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width:1%;">id</th>
					<th style="width:6%;">仓库名称</th>
					<th style="width:4%;">项目名称</th>
					<th style="width:6%;">项目时间</th>
					<th style="width:6%;">创建者</th>
					<th style="width:8%;">版本号</th>
					<th style="width:8%;">项目描述</th>
				</tr>
			</thead>
			<tbody>
				<?php if($version):?>
				<?php $i=1;foreach($version as $dt):?>
				<tr>
					<td><?=$i?></td>
					<td>
						<?
						if(isset($repo[$dt->repo_id])){
							echo $repo[$dt->repo_id]->title;
						}
						?>
					</td>
					<td><?=$dt->title?></td>
					<td><?=$dt->time?></td>
					<td>
						<?
						if(isset($user[$dt->uid])){
							echo $user[$dt->uid]->uname;
						}
						?>
					</td>
					<td><?=$dt->version?></td>
					<td><?=$dt->memo?></td>


				</tr>
				<?php $i++; endforeach?>
				<?php endif?>
			</tbody>
		</table>
	</section>
</div>
<?=_v('footer.tpl')?>