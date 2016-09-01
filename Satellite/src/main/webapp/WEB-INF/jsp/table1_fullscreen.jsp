<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-control" content="no-cache">
	<meta http-equiv="Cache" content="no-cache">
	
	<link href="css/mybootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/roll/site.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/scroll/scroll.css">
	<link rel="stylesheet" href="css/scroll/jquery.mCustomScrollbar.css">

</head>

<body style="height:100%;overflow:hidden">
	<div>
		<div class="container mp30">
			<div class="row" style="height:50%;padding-bottom:1%">
				<div class=" col-lg-8" style="height:100%;overflow:auto">
					<span style="color:red">
						<center>
							<font size="+1">数据接口状态(Data Interface Status)</font>
						</center> </span>
					<ul>
						<li>TCP/IP链路状态(Heart Beat Check) <span class="pull-right"
							style="color:green">OK</span>
						</li>
						<li>数据传输成功率(Data Trans Suc Rate) <span class="pull-right">100%</span>
						</li>
						<li>数据平均传输速率(Data Trans Speed) <span class="pull-right"
							id="speed_iframe"></span>
						</li>
					</ul>
				</div>
				<div class="col-lg-4" style="height:100%;overflow:auto">
					<span style="color:red">
						<center>
							<font size="+2">北斗授时</font>
						</center> </span> <span style="color:red;-webkit-text-size-adjust: none;">
						<center>
							<font size="+1"><div id="clock_iframe"></div> </font>
						</center> </span>
				</div>
			</div>
			<div class="row" stylr="height:70%">
				<div class="col-md-12">
					<div class="panel panel-info">
						<div class="panel-heading">
							<b>Logs</b>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-12">
									<ul id="demo3_1jsp" style="overflow:hidden;">
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="js/jquery.min.js" type="text/javascript"></script>

	<script src="js/scroll/jquery.bootstrap.newsbox.min.js"></script>
	<script src="js/scroll/jquery.mCustomScrollbar.concat.min.js"></script>
	<script type="text/javascript">
		$(function() {
		
			var height = document.documentElement.clientHeight;//设置高度
			$("#demo3_1jsp").height(height * 0.7);//设置panel1的高度自适应

			var speed = $("#fileSpeed", window.parent.document).html();
			$("#speed_iframe").html(speed);
			startTime();

			//填充数据
			$.ajax({
				type : "get",
				dataType : "json",
				url : "datalog/getDataLog",
				success : function(msg) {
					/*alert("success");*/
					var str = "";
					for ( var i = msg.length - 1; i >= 0; i--) {
						str = str + "<li class='news-item'>" + "dataFormat:"
								+ msg[i].dataFormat + " | dataSize:"
								+ msg[i].dataSize + " | dataType:"
								+ msg[i].dataType + " | reqCode:"
								+ msg[i].reqCode + " | status:" + msg[i].status
								+ " | type:" + msg[i].type + " | time:"
								+ msg[i].time + "</li>";
					}
					document.getElementById("demo3_1jsp").innerHTML = str;
					$("#demo3_1jsp").mCustomScrollbar({
					axis : "y",
					scrollButtons : {
						enable : true
					},
					theme : "3D",
					scrollbarPosition : "inside"
				});
				},
				error : function() {
				}
			});
			
			
			
		});

		//set the clock in the table1
		function startTime() {
			var today = new Date();
			var year = today.getFullYear();
			var month = today.getMonth() + 1;
			var day = today.getDate();
			var h = today.getHours();
			var m = today.getMinutes();
			var s = today.getSeconds();
			var ms = today.getMilliseconds();
			// add a zero in front of numbers<10
			m = checkTime(m);
			s = checkTime(s);
			ms = checkTime2(ms);
			document.getElementById('clock_iframe').innerHTML = year + "-"
					+ month + "-" + day + "<br>" + h + ":" + m + ":" + s + "."
					+ ms;
			t = setTimeout('startTime()', 50);
		}

		function checkTime(i) {
			if (i < 10) {
				i = "0" + i;
			}
			return i;
		}

		function checkTime2(i) {
			if (i < 10) {
				i = "00" + i;
				return i;
			}
			if (i < 100) {
				i = "0" + i;
				return i;
			}
			return i;
		}
	</script>

</body>
</html>