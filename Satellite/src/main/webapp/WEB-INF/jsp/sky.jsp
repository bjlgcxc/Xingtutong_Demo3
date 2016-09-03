<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>html5绘制天空图</title>
	<style>
		#skyPic{
			width: 390px;
			height: 390px;
		}
	</style>

	<script src="js/jquery.min.js"></script>
</head>

<body style="zoom:1">
	<center>
		<div>
			<canvas id="skyPic" width="390" height="390" ></canvas>
		</div>
	</center>
	
	<script>
     	//sky
		function myzoom(){
			var height = $('#cesiumContainer3', parent.document).height();
			var zoomValue = height/400;
			var mytransform = "scale(";
			mytransform = mytransform+zoomValue + "," + zoomValue +")";
			document.body.style.transform=mytransform;
			
			document.body.style.transformOrigin=" top";
		}
		
		var RADIUS;
		// 绘制背景
		function drawBaseSky(cxt){
			cxt.clearRect(0,0,390,390);//清空画布

			RADIUS = 180;//半径
			
			cxt.save();	//保存状态

			cxt.translate(15,15);//坐标原点移动，留出边界值，让可能出现在最外层的信息能显示

			//绘制背景
			cxt.beginPath();
			cxt.arc(RADIUS, RADIUS, RADIUS, 0, Math.PI*2);
			cxt.strokeStyle="white";
			cxt.stroke();

			cxt.beginPath();
			cxt.fillStyle ='white';
			cxt.arc(RADIUS, RADIUS, RADIUS*2/3, 0, Math.PI*2, false);
			cxt.strokeStyle="white";
			cxt.stroke();

			cxt.beginPath();
			cxt.fillStyle = 'rgb(255,255,255)';
			cxt.arc(RADIUS, RADIUS, RADIUS/3, 0, Math.PI*2, false);
			cxt.strokeStyle="white";
			cxt.stroke();

			cxt.save();	//保存状态

			//通过旋转的方式画圆中的分割线
			cxt.beginPath();
			cxt.strokeStyle = 'rgb(255,255,255)';
			cxt.translate(RADIUS,RADIUS);
			var position = new Array("W","N","E","S");
			for(var i=0;i<4;i++){
				cxt.rotate(Math.PI/180*90);
				cxt.moveTo(0,0);
				cxt.lineTo(0,RADIUS);
			}
			cxt.stroke();
			
			cxt.strokeStyle="#ffffff";
			cxt.font = "20px 微软雅黑";
			cxt.strokeText("S",3,RADIUS-5);
			cxt.strokeText("W",RADIUS-25,0);
			cxt.strokeText("N",3,-RADIUS+20);
			cxt.strokeText("E",-RADIUS+3,0);

			cxt.restore();
			cxt.restore();
			imageData = cxt.getImageData(0, 0, 390,390);
		}
		//绘制数据分布
		function drawSkyPosition(drawData,cxt){
			cxt.putImageData(imageData, 0, 0);
			var color ={
				"1":"rgb(217, 234, 211)", 
				"2":"rgb(75,164,259)", 
				"3":"rgb(226,120,228)",
				"4":"rgb(117,173,61)", 
				"5":"rgb(230,139,55)", 
				"6":"rgb(61,168,161)",
				"7":"rgb(224, 102, 102)",
				"8":"rgb(111, 168, 220)",
				"9":"rgb(207, 226, 243)",
				"10":"rgb(230, 184, 175)",
				"11":"rgb(204, 51, 102)",
				"12":"rgb(153, 255, 51)",
				"13":"rgb(255, 217, 102)",
				"14":"rgb(234, 209, 220)",
				"15":"rgb(88, 201, 22)",
				"16":"rgb(230, 184, 175)",
				"17":"rgb(153, 255, 255)",
				"18":"rgb(238, 162, 173)",
				"19":"rgb(102, 205, 170)",
				"20":"rgb(239, 255, 102)",
				"21":"rgb(167, 128, 9)",
				"22":"rgb(215, 193, 168)"
			}; 
			// var cxt = document.getElementById('skyPic').getContext("2d");
			var radius = 180;//半径
			var x,y;

			cxt.save();
			cxt.translate(15,15);
			cxt.translate(radius,radius);

			cxt.font = "bold 14px Arial";
			cxt.textAlign = "center";
			cxt.textBaseline = "middle";

			for(var i=0,dataLen = drawData.length;i<dataLen;i++){
				cxt.beginPath();
				cxt.fillStyle = color[drawData[i].type];

				//关键代码。求圆心坐标。coslen是求出来的该点到圆心的距离。
				
				y = drawData[i].x;
				x = drawData[i].y;

				cxt.arc(x,-y , 14, 0, Math.PI*2, false);//在坐标点绘制圆
				cxt.fill();

				cxt.beginPath();
				cxt.fillStyle ='black';
				cxt.fillText(drawData[i].num, x, -y);//在坐标点写文字卫星号
			}
			cxt.restore();
		}
		function getRandom(n){
			return Math.floor(Math.random()*n+1);
		}
		
		//y仰角 x方位角。这里生成随机数据。
		function createBaseDate(){
			drawData = [];
			var item;
			var j;
			for(j = 0 ;j<dataNum;j++){
				var x = data[j+1].position.cartesian[4*i+1] - std_x;
				var y = data[j+1].position.cartesian[4*i+2] - std_y;
				var z = data[j+1].position.cartesian[4*i+3] - std_z;
				var tmp_arccos = (x*std_x+y*std_y+z*std_z)/(Math.sqrt(x*x+y*y+z*z)*Math.sqrt(std_x*std_x+std_y*std_y+std_z*std_z));
				if(tmp_arccos > 0){
					item = {"type":(j+1),"num":satName[j], "y":y/12712156/4*RADIUS,"x":x/12712156/4*RADIUS};
					drawData.push(item);
				}
			}	
			if(drawData.length >= 8){
				console.log(drawData.length);
			}
			console.log("i:"+i);
			i = i + 1;
			if(i >= 291){
				i = 0;
			}
		}
		
		function getData() {
			$.ajax({
		        url: 'data/OrbitData.txt',
		        dataType: 'json',
		        async:false,
		        error: function(xhr) { alert( xhr.responseText ); }, //如果你的url,txt有问题,将会提示
		        success: function(msg) {
		            data = msg;
		        }
		    });
	    } 
	
		function newSky(){
			myzoom();
			getData();
			drawBaseSky(cxt);
			createBaseDate();
			drawSkyPosition(drawData,cxt);
		}

		function loop(){
			createBaseDate();
			drawSkyPosition(drawData,cxt);
		}
		
		//定时刷新
		var drawData = [];
		var satName = ["G1","G3","I1","G4","I2","I3","I4","I5","G5","M3","M4","M6","G6","1S","M1","M2","2S","3S","I6","G7"];
		var cxt = document.getElementById('skyPic').getContext("2d");
		var imageData;
		var data;
		var dataNum = 20;
		var i = 0;
		var std_x = -2180687.939;
		var std_y = -1823771.993;
		var std_z = 5690590.529;
		newSky();
		var skyinterval = setInterval(function(){
			loop();
		},300000);	
	</script>
</body>