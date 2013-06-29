<?php
$config = array(
	'__claim__'=>array(
		array(
			'field'=>'claim_title',
			'label'=>'分享标题',
			'rules'=>'trim|required|xss_clean',
		),
		array(
			'field'=>'description',
			'label'=>'简要描述',
			'rules'=>'trim|required',
		)
	),
	
);
