<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">  
	<title>Invest</title>
	<meta name="generator" content="editplus">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7,chrome=1" />
	<meta content="牛赞网 牛赞 newzan 推荐 信息大爆炸 社会化阅读 社会化媒体营销 信息聚合 推荐系统 个性化推荐" name="keywords">
	<link rel="stylesheet" type="text/css" href="/public/css/error.css" media="all">
	<link rel="shortcut icon" href="/public/image/favicon.png">
</head>
<body>
	<div id="main">
		<div class="left">
			<h1><a href="/" title="访问牛赞首页">Tips</a></h1>
			<h2 class="not">404 NOT FOUND</h2>
			<?
				$page = '';
				if(is_array($heading)){
					foreach($heading as $p){
						$page .= '/' . $p;
					}
				}else{
					$page = $heading;
				}
			?>
			<p>很抱歉，您请求的页面 <em><?=$page?></em> 不存在</p>
			<p>请换个地址试试！</p>
		</div>
		<div class="right"></div>
	</div>
</body>
</html>