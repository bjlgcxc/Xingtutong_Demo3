<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String sslbasePath = "https://" + request.getServerName() + ":8443"
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>星途通云平台首页_北京星途通科技有限公司</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">

<link rel="stylesheet" type="text/css" href="css/eplist/easyui.css">
<link href="css/mybootstrap.min.css" rel="stylesheet">
<link href="css/sb-admin-2.css" rel="stylesheet">

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/updatetable.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>

<body style="zoom:1;overflow:hidden">
	<div class="row" style="height:14%;">
		<div class=" col-lg-8" style="height:100%;overflow:auto">
			<span style="color:red">
				<center>
					<font size="+1">数据接口状态(Data Interface Status)</font>
				</center> </span>
			<ul>
				<li>TCP/IP链路状态(Heart Beat Check) <span class="pull-right"
					style="color:green">OK</span></li>
				<li>数据传输成功率(Data Trans Suc Rate) <span class="pull-right">100%</span>
				</li>
				<li>数据平均传输速率(Data Trans Speed) <span class="pull-right"
					id="speed_iframe"></span></li>
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
		<div style="float:right;"><input type="checkbox" value="暂停数据动态刷新" id="close">暂停数据动态刷新&nbsp;&nbsp;&nbsp;&nbsp;</div>
	</div>
	<div id="table" style="height:85%;width:100%">
		<table id="order"></table>
	</div>
</body>

<script type="text/javascript">
	$(function() {
		//webSocke
		var hostport = document.location.host;
		var socketurl = 'ws://' + hostport + '/Satellite/webSocket';
		var ws = new WebSocket(socketurl);
		/* ws.onopen = function() { 
			alert('webSocket connet');
		};  */
		ws.onmessage = function(event) {
			if(false == $("#close").attr("checked"))
				$("#order").datagrid('load');
		};
		ws.onerror = function() {
			/* alert('webSocket连接失败'); */
		};
	
	
		document.body.style.zoom = document.body.clientWidth / 1366;
		startTime();
		$("#order").datagrid({
			iconCls : 'icon-edit',
			fit : true,
			pageSize : 20,//每页显示的记录条数，默认为10  
			style : {
				padding : '8 8 10 8'
			},
			singleSelect : true,
			method : 'get',
			url : 'datalog/getDataLog',
			onLoadError : function() {
				slide("提示信息", "数据信息错误");
				return;
			},
			loadMsg :null,
			pagination : true,
			rownumbers : true,
			title : "卫星数据交换日志",
			//sortOrder:'desc',
			columns : [ [ {
				field : 'time',
				title : '时间',
				align : 'center',
				width : 260,
			}, {
				field : 'dataFormat',
				title : '数据格式',
				align : 'center',
				width : 240
			}, {
				field : 'dataSize',
				title : '数据大小',
				align : 'center',
				width : 220
			}, {
				field : 'dataType',
				title : '数据类型',
				align : 'center',
				width : 200
			},{
				field : 'status',
				title : '状态',
				align : 'center',
				width : 200
			},{
				field : 'type',
				title : '类型',
				align : 'center',
				width : 195,
				formatter: 
					function(value,row,index){
          				if(value==1)
          					return 'request';
          				else
          					return 'response';				
					}
			}
			 ] ]

		});
		var p = $("#order").datagrid("getPager");
		$(p).pagination({
			pageSize : 20,//每页显示的记录条数，默认为10      	 	
			pageList : [ 10, 20, 30, 40, 50 ],//可以设置每页记录条数的列表	        
			beforePageText : '第',//页数文本框前显示的汉字  
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
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

</html>



