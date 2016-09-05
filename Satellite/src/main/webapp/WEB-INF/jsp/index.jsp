<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = 
			request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>北斗国家数据中心与山西分中心的数据交换系统</title>
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<link href="css/mybootstrap.min.css" rel="stylesheet">
	<link href="css/sb-admin-2.css" rel="stylesheet">
	<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="css/roll/site.css" rel="stylesheet" type="text/css" />
	<link href="css/scrollstyle.css" rel="stylesheet" type="text/css" />
	
	
	<link rel="stylesheet" href="css/scroll/scroll.css">
	<link rel="stylesheet" href="css/scroll/jquery.mCustomScrollbar.css">

	<script src="js/jquery.min.js"></script>
	<script src="js/scroll/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/sockjs-0.3.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/chart6/mikuCanvasAxes.js"></script>
	<script src="js/Sandcastle-header.js"></script>
	<script src="Build/Cesium/Cesium.js"></script>
	
	<style>
		@import url(Build/Cesium/Widgets/widgets.css);
		html, body, #cesiumContainer {
			width: 100%; height: 100%; margin: 0; padding: 0; 
		}
	</style>

	<style>
	.grid{table-layout:fixed;}
    .grid th {overflow: hidden;white-space: nowrap;padding: 0;text-align: left;vertical-align: middle;width: 90px;max-width: 90px;border-width: 0 1px 1px 0;color:#fff}
    .grid td {overflow: hidden;white-space: nowrap;width: 90px;max-width: 90px;height: 16px;line-height: 16px;font-size: 13px;border-width: 0 1px 1px 0;text-align:left;vertical-align: middle;padding: 1px 2px;}
    .grid th:first-child, .grid td:first-child {width: 148px;text-align: left;color: #fff;padding-left: 4px;}
	
	</style>

</head>

<body onload="startTime()">
	<%@ include file="nav.jsp"%>
	<%@ include file="row1.jsp"%>
	<%@ include file="row2.jsp"%>
</body>

<script type = "text/javascript" src ="js/fullscreen.js"></script>
<script type = "text/javascript" src ="js/updatetable.js"></script>
<script src="js/roll/jquery.bootstrap.newsbox.min.js" type="text/javascript"></script>

<script type="text/javascript">
		(function($) {
			$(window).load(function() {
				$("#panel1body11").mCustomScrollbar({
					axis : "yx",
					scrollButtons : {
						enable : true
					},
					theme : "dark-thin",
					scrollbarPosition : "inside"
				});
				$("#panel1body12").mCustomScrollbar({
					axis : "yx",
					scrollButtons : {
						enable : true
					},
					theme : "dark-thin",
					scrollbarPosition : "inside"
				});
				$("#panel1body21").mCustomScrollbar({
					axis : "xy",
					scrollButtons : {
						enable : true
					},
					theme : "dark-thin",
					scrollbarPosition : "outside"
				});
				$("#form1").mCustomScrollbar({
					axis : "xy",
					scrollButtons : {
						enable : true
					},
					theme : "dark-thin",
					scrollbarPosition : "outside"
				});
				$("#panel3boody1").mCustomScrollbar({
					axis : "y",
					scrollButtons : {
						enable : true
					},
					theme : "dark-thin",
					scrollbarPosition : "outside"
				});
			});
		})(jQuery);

	$(document).ready(function() {
		//webSocke
		var hostport = document.location.host;
		var socketurl = 'ws://' + hostport + '/Satellite/webSocket';
		var ws = new WebSocket(socketurl);
		/* ws.onopen = function() { 
			alert('webSocket connet');
		};  */
		ws.onmessage = function(event) {
			update_table2();
		};
		ws.onerror = function() {
			/* alert('webSocket连接失败'); */
		};
		
		myresize();
		var frame = document.getElementById("skyFrame");
		frame.style.height = "100%";
		update_table1();
		update_table2();
		update_table3(table2_body, 6);
		update_viewer();
	});
	
	/*屏幕适配*/
	window.onresize = function() {
		var isFullScreen = document.msFullscreenElement!=null || document.webkitFullscreenElement!=null ||
					 document.mozFullScreenElement!=null;
		if (isFullScreen) {
			//全屏
		} else if (!isFullScreen){
			doresize();
		}
	};
	function doresize(){
		myresize();
		document.getElementById("skyFrame").contentWindow.myzoom();//resize 'skyFrame'
		document.getElementById('display').innerHTML = '';//clear 'display'
		$("#form1").css("background", "rgba(0,0,0,0)");//set table2's background
		viewer1.animation.container.style.visibility = "hidden";//hide viewer's animation
		viewer1.timeline.container.style.visibility = "hidden";
		viewer2.animation.container.style.visibility = "hidden";
		viewer2.timeline.container.style.visibility = "hidden";
		viewer1.animation.viewModel.shuttleRingAngle = 15;//set viewer's default speed
		viewer2.animation.viewModel.shuttleRingAngle = 15;
	}
	function myresize() {//resize elements' size
	
		document.getElementById('display').innerHTML = '';//清空display

		var height = document.documentElement.clientHeight;//设置高度
		var height1 = $("#nav").height();
		height = height - height1 - 60;
		var tmp = height / 2 + "px";
		$(".parent").css("height", tmp);

		$("#panel1body21").height($("#panel1").height()-$("#panel1head").height()*1.5-$("#panel1body1").height()*1.5) *0.9 - 60;//设置panel1的高度自适应
		$("#form1").height($("#panel2").height()-$("#panel2head").height()*1.5-$("#panel2body1").height()*1.5) *0.9 - 60;//设置panel1的高度自适应
		$("#panel3boody1").height($("#table2").height()-$("#heading").height()*1.5-$("#thead3").height()*1.5) *0.9 - 60;//设置panel3的高度自适应
		
		$("#cesiumContainer1").height($("#table2").height()-$("#heading").height());
		$("#cesiumContainer2").height($("#table2").height()-$("#heading").height());
		$("#cesiumContainer3").height($("#table2").height()-$("#heading").height());
		$("#cesiumContainer3").width($("#table2").width());
	}
	//全屏改变事件
	document.addEventListener("mozfullscreenchange", function(e) {
  		if(!e.currentTarget.mozFullScreen)
  			doresize();
	});
	document.addEventListener("webkitfullscreenchange", function(e) {
  		if(!e.currentTarget.webkitIsFullScreen)
  			doresize();
	});
	document.addEventListener("MSFullscreenChange", function(e) {
  	    if(document.msFullscreenElement==null){
  	    	setTimeout(function(){doresize();},300);
  	    }
	});
</script>

</html>
