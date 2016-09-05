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

<body style="zoom:1">
	</br>
	<div style="height:2%;">
		<div>
			<input id="Token" type="hidden" name="Token" value="" />
			<div style="float:right;"><input type="checkbox" value="数据动态刷新" id="pauseRefresh" checked="checked"/>数据动态刷新&nbsp;&nbsp;&nbsp;&nbsp;</div>
		</div>
	</div>
	<div style="height:96%;width:100%">
		<table id="order"></table>
	</div>
</body>

<script type="text/javascript">
	//webSocke
	var hostport = document.location.host;
	var socketurl = 'ws://' + hostport + '/Satellite/webSocket';
	var ws = new WebSocket(socketurl);
	/* ws.onopen = function() { 
		alert('webSocket connet');
	};  */
	ws.onmessage = function(event) {
		if(refresh)
			$("#order").datagrid('load');
	};
	ws.onerror = function() {
		/* alert('webSocket连接失败'); */
	};
	
	var refresh = true;
  	$("#pauseRefresh").click(function(){
  		refresh = !refresh;
  	});

	$(function() {
		document.body.style.zoom = document.body.clientWidth / 1366;
		$("#order").datagrid({
			iconCls : 'icon-edit',
			fit : true,
			pageSize : 20,//每页显示的记录条数，默认为10  
			style : {
				padding : '8 8 10 8'
			},
			singleSelect : true,
			method : 'get',
			url : 'message/getPageMessage',
			/* loadFilter:function(data){
			if(data.rows.length==0){
				slide("提示信息","没有数据信息");
			}else{
				return data;
			}
			},   */
			onLoadError : function() {
				slide("提示信息", "数据信息错误");
				return;
			},
			loadMsg :null,
			pagination : true,
			rownumbers : true,
			title : "北斗短报文收发记录",
			columns : [ [ {
				field : 'time',
				title : '时间',
				align : 'center',
				width : 200,
				formatter : function(value) {
					return GetDateTimeFormatStr(new Date(value));
				}
			}, {
				field : 'from',
				title : '发送ID',
				align : 'center',
				width : 120,
			}, {
				field : 'to',
				title : '接收ID',
				align : 'center',
				width : 110,
			}, {
				field : 'type',
				title : '类型',
				align : 'center',
				width : 120,
				formatter : function(value) {
					if (value == "1") {
						return "receive";
					} else
						return "send";
				}
			}, {
				field : 'content',
				title : '内容',
				align : 'center',
				width : 765,
			},

			] ],
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
</script>

</html>



