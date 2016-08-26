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

	<script src="js/jquery.min.js"></script>
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

	$(document).ready(function() {
		//webSocke
		var hostport = document.location.host;
		var socketurl = 'ws://' + hostport + '/Demo3/webSocket';
		var ws = new WebSocket(socketurl);
		/* ws.onopen = function() { 
			alert('webSocket connet');
		};  */
		ws.onmessage = function(event) {
			update_table2();
		};
		ws.onerror = function() {
			alert('webSocket连接失败');
		};
		
		myresize();
		var frame = document.getElementById("skyFrame");
		frame.style.height = "100%";
		update_table1();
		update_table2();
		update_table3(table2_body, 6);
		update_viewer();

	});

	window.onresize = function() {
		if (document.webkitIsFullScreen == true) {//全屏
			//	alert("quanping");
		} else if (document.webkitIsFullScreen == false) {
			//	alert("tuichuquanping");
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

	};

	function myresize() {//resize elements' size
		var width = $("#panel1").width();
		width = width * 0.98;
		var w1 = width + "px", w2 = width + 30 + "px";
		$("#panel1body21").width(w1);
		$("#panel1body22").width(w2);
		document.getElementById('display').innerHTML = '';

		var height = document.documentElement.clientHeight;
		var height1 = $("nav").height();
		height = height - height1;
		var tmp = height / 2 + "px";
		$(".parent").css("height", tmp);//row1

		$("#cesiumContainer1").height($("#table2").height());
		$("#cesiumContainer2").height($("#table2").height());
		$("#cesiumContainer3").height($("#table2").height());
		$("#cesiumContainer3").width($("#table2").width());

	}
</script>

</html>
