<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String sslbasePath = "https://"+request.getServerName()+":8443"+path+"/";
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
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
</head>

<body style="zoom:1">
	<div>
		<input id="Token" type="hidden" name="Token" value="" />
	</div>
	<table id="order"></table>
</body>

<script type="text/javascript">
    
  $(function(){ 
    document.body.style.zoom=document.body.clientWidth/1366;
		$("#order").datagrid({
			iconCls:'icon-edit',
			fit: true, 
			pageSize: 10,//每页显示的记录条数，默认为10  
		    style:{padding:'8 8 10 8'},                 
	        singleSelect:true,  
	        method:'get',
	        url: 'Data/EpList/getEphemerisList',
	          /* loadFilter:function(data){
	        	if(data.rows.length==0){
	        		slide("提示信息","没有数据信息");
	        	}else{
	        		return data;
	        	}
	        },   */
	        onLoadError: function () {
		    	   slide("提示信息","数据信息错误");  
		           return;
		       },
	        loadMsg:'数据加载中请稍后……',  
	        pagination: true,  
	        rownumbers: true,     
	        title:"北斗短报文收发记录",
	        columns:[[  
	                   {field:'satellitenumber',title:'卫星编号',align:'center',width:60},
		               {field:'deltan',title:'平近点角速度修正值',align: 'center',width: 120,},  
		               {field:'m0',title:'平近点角',align: 'center',width: 110, },
		               {field:'e',title:'轨道偏心率',align: 'center',width: 120,  }  , 
		               {field:'sqrtA',title:'轨道长半径平方根',align: 'center',width: 120, }  , 
		               {field:'toe',title:'星历参考时刻',align: 'center',width: 90,} ,
		               {field:'omega0',title:'轨道升交点赤径',align: 'center',width: 100, } ,
		               {field:'i0',title:'轨道倾角',align: 'center',width: 90, }, 
		               {field:'omega',title:'近地点角距',align: 'center',width: 90, } ,
		               {field:'omegadot',title:'升交点赤径变化率',align: 'center',width: 120,},
			           {field:'idot',title:'倾角变化率',align: 'center',width: 90,	} ,  
		               {field:'xk',title:'地固坐标X',align: 'center',width: 100, },  
		               {field:'yk',title:'地固坐标Y',align: 'center',width: 100, },   
		          ]],
	 
			});
			var p = $("#order").datagrid("getPager");  
		       $(p).pagination({  
		    	pageSize: 10,//每页显示的记录条数，默认为10      	 	
		   	    pageList: [10,20,30,40,50],//可以设置每页记录条数的列表	        
		   	    beforePageText: '第',//页数文本框前显示的汉字  
		        afterPageText: '页    共 {pages} 页',  
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',  
		    });  
		});
   
	    var editIndex = undefined;
		function submit(type,url,data){
			$.ajax({
			    crossDomain:true,
				type: type,
				url: url,
				dataType:'json',
				contentType: 'application/json; charset=utf-8',
				data:data,
				beforeSend:function(xhr){
					var token = $("#Token").val();
					xhr.setRequestHeader('Authorization', token);
				},  
				xhrFields: {
		                  withCredentials: true,
		                  useDefaultXhrHeader: false
		            }, 
				success:function(data){
					if(data.Status=="Success"){
						slide("提示","保存成功");
						$("#order").datagrid('acceptChanges');
						$("#order").datagrid('reload');
						editIndex = undefined;
					}else if(data.Status=="Fail"){
						slide("提示","保存失败");
					}else if(data.Status=="NoPass"){
						$("#Token").val(data.Token);
						submit(type,url,data);
					}else if(data.message!=undefined){
					    slide("提示信息",data.message);
					}
				},
				error:function(result){
					var str=result.responseText;
		   			merror("系统异常",str);	
				}
			});
	}  
	
</script>

</html>



