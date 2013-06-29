<?=_v('header.tpl')?>

<div class="adminbody">
	<br>
	<br>
	<table class="table table-bordered score">
		<tr>
			<th style="width:30%">用户名</th>
			<th style="width:10%">邮箱</th>
			<th style="width:10%">级别</th>
			<th style="width:10%">状态</th>
			<th style="width:10%">操作</th>
		</tr>
		<?foreach ($users as $key => $value):?>
		<tr>
			<td><?=$value->uname?></td>
			<td>
				<strong><?=$value->email?></strong>
			</td>
			<td><?=$value->level?></td>
			<td><?=$value->active?></td>
			<td>
				<a href="/user/active/<?=$value->id?>">激活</a>
				<a href="/user/noactive/<?=$value->id?>">禁用</a>
				<a href="/user/edit/<?=$value->id?>">修改</a>
			</td>
		</tr>
		<?endforeach?>
	</table>
</div>
<?=_v('footer.tpl')?>