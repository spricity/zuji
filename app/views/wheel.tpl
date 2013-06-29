<?_v('header.tpl');?>
<section class="main" stlye="overflow:hidden"   > 
	<canvas  id="canvas" width=700 height=600 style="position:relative;left:28%;" ></canvas>
	<script src='<?=B?>/html/js/jquery.js'></script>
		<script type="text/javascript" src="<?=B?>/html/js/paper.js"></script>
	<script type="text/paperscript" canvas="canvas">
	 

		
		var PI = Math.PI,
		NUM = 12,
		layer = new Layer(),
		A,
		
		center = new Point(300,300),
		DON = true,
		XON = true,
		openCount=0,
		Cache = [],
		CEN,
		Flag,
		Timer,
		Title,
		aModle = [];

		
		function drawText(x,y,txt){
			
			var raster = new Raster(createImg({"id":parseInt(txt)},true));
			raster.position = new Point(x,y);
			raster.size = new Point(30,30);
			
			var path = new Path.Circle(new Point(x,y), 45);
			var opacity = new Path.Circle(new Point(x,y), 37);
			opacity.fillColor = "#fff";
			opacity.opacity = 0;
			
			path.style = {
				strokeColor: '#D2D3D3',
				strokeWidth: 19
			};

			group = new Group([path,raster,opacity]);
			group.name = "wheel";
			group.info = "2012-"+txt.match(/\d+/)[0];
			return group;
		}
		
		function drawCircle(x,y,data){	

			var	raster,path,opacity,group;
			raster = new Raster(createImg({"id":data.ID,"url":data.post_img}));
			raster.position = new Point(x,y);
			raster.size = new Point(75,75);
			
			path = new Path.Circle(new Point(x,y), 45);
			opacity = new Path.Circle(new Point(x,y), 31);
			opacity.fillColor = new RgbColor(1, 0, 0);
			opacity.opacity = 0;
			
			path.style = {
				strokeColor: '#D2D3D3',
				strokeWidth: 14
			};
			
			group = new Group([raster,path,opacity]);
			group.url = data.guid;
			group.title = data.post_title;
			group.name = "read";
			
			return group;
		}
		
		
		function drawCenterCircle(rt){
			var path = new Path.Circle(center, 45),group;;

			path.style = {
				strokeColor: '#D2D3D3',
				strokeWidth: 25
			};

			var	opacity = new Path.Circle(center, 37);
			opacity.fillColor = "#fff";
			opacity.opacity = 1;

			if(rt.indexOf("-") > 0)
				var text = new PointText(new Point(275,302));
			else{
				var text = new PointText(new Point(285,302));
			}
			text.fillColor = 'black';
			text.content = rt;
			
			group =new Group([opacity,path,text]);
			group.name = "center";
			group.info = rt;
			Cache["center"] = group;
		}		
			
			
		function  flash(){
			var _group=[],
				data = Cache[CEN]? Cache[CEN].data : "",
				len =data ? data.length : 0,
				raster,
				id,
				image;

			if(!data) return ;
			if(Flag == 1 ){
				for(var i = 0; i<len;i++){
					image = aModle[i]._children[1];
					pos = image.position;
					image.remove();
					id = parseInt(data[i]);
					raster = new Raster(createImg({'id':id},true));
					raster.position = pos;
					raster.size = new Point(30,30);
					aModle[i].insertChild(1,raster)
				}	
			}else if(Flag == 2){
				for(var i = 0; i<len;i++){
					image = aModle[i]._children[0];
					pos = image.position;
					raster = new Raster(createImg({'id':data[i].ID,'url':data[i].post_img}));
					image.remove();
					raster.position = pos;
					raster.size = new Point(75,75);
					aModle[i].insertChild(0,raster);
					
				}	
			}
		}
		function createImg(data,key){
			var id = data.id ? data.id : "",
				url =  data.url ? data.url : "";
			if( key && (Cache["local-"+id])){
				return Cache["local-"+id];
			}	
			
			var dom = document.createElement("img");
				
				dom.src = key ? F.data('BASE')+"/html/image/"+id+".png" : url;
				dom.id = (Math.random()+"").substring(3,10);
				dom.style.display = "none";
				
				if(!key){
					if($("#"+Cache['img-'+id]).attr("id")){
						$("#"+Cache['img-'+id]).remove();
					}
					Cache["img-"+id] = dom.id;
				}
				else{
					Cache["local-"+id] = dom.id;
				}
				$("body").append(dom);
				return dom.id;
		}		
			


		function onFrame(event) {
			if(XON && DON){
				var len =aModle.length;
				for(var i =0;i<len;i++){
					aModle[i].rotate(1, center);
				}
			}
		}

		function onMouseDown(event){
			var item = event.item;

			if(event.item && event.item.name){
				switch(item.name){
					case "read":
						window.open(item.url);
						break;
					case "wheel":
						layer.removeChildren();
						ajaxGetData(item.info);
						break;
					case "center":
						var s = item.info;pos = s.lastIndexOf("-");
						if(pos > 0){
							layer.removeChildren();
							ajaxGetData(s.substr(0,pos));
						}
				}
			}
		}
		
		function onMouseMove(event){
			var item = event.item;
			if(!item || item.name != "center"){
				if(Cache['center'])
					Cache['center'].opacity = 1;
			}
			if(item && item.name){
				XON = false;
				if(item.name == "center"){
						if(item.info.lastIndexOf("-") > 0)
							item.opacity = 0.5;
				}else if(item.name == "read"){
					if(!Title){
						Title = new PointText(item.position-new Point(10,50));
						Title.fillColor = 'black';
						Title.content = item.title;
					}
				
				}
			}else{
				if(Title){
					Title.remove();
					Title = "";
				}
				XON = true;
			}	
		}

		function translate(item,point,time){
			var xD = item.position.x - point.x,
				yD = item.position.y - point.y,
				timer,
				times = time/50;
				timer = setInterval(function(){
					item.position = item.position - new Point(xD/times,yD/times);
					if( ((xD>0&& item.position.x < point.x) || (xD<0&&item.position.x > point.x)) || (yD>0&& item.position.y < point.y) || (yD<0&&item.position.y > point.y) ){
						item.position = point;
						clearInterval(timer);
					}
				},50);
		}
		
		
		
		function ajaxGetData(time){
			 var time =time ? time : 2012;
			  CEN = time ;
			  if(!Cache[time]){
					$.post(F.data("BASE")+"/misc/wheel",{"time":time},function(result){
						Cache[time] = F.json(result);
						openCircle(Cache[time]);
					})
			  }else{
				openCircle(Cache[time]);
			  }
				clearInterval(Timer);
		}

		function drawContainer(){
			var path = new Path.Circle(center, 225);
			path.strokeColor ="#000";
		}
		
		function openCircle(data){
			aModle = [];
			Flag = data.flag;
			var g,
				rt = data.data ? data.data : [],
				len = rt.length,
				cen = data.cen;

			drawContainer();
			drawCenterCircle(cen+"");
			if(data.flag == 2){
				for(var i = 0; i< len ;i++){
					var D = PI*2/len,
					A = i*D,
					x = parseInt(300+225*Math.cos(A)),
					y = parseInt(300+225*Math.sin(A));
					aModle.push(g = drawCircle(300,300,rt[i]));
					translate(g,new Point(x,y),500);
				}
			}else if(data.flag == 1){
				for(var i = 0; i< len ;i++){
					var D = PI*2/len,
					A = i*D,
					x = parseInt(300+225*Math.cos(A)),
					y = parseInt(300+225*Math.sin(A));
					aModle.push(g = drawText(300,300,rt[i]));
					translate(g,new Point(x,y),500);
				}
			}
			
			Timer = setInterval(flash,800);
		}

		
		function clear(){
			layer.removeChildren();
		}

	ajaxGetData("2012");

	</script>
	<canvas id="canvas" resize></canvas>
</section>
<?=_v('footer.tpl');?>
