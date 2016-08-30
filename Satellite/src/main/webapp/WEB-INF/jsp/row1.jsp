<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="parent" >
	
	<!-- 1.数据交换日志 -->
	<div class="left" >
		<div class="panel panel-warning" style="height:100%;width:100%" id="panel1">
            <div class="panel-heading"  id="panel1head">数据交换日志
				<button type="button" class="pull-right btn btn-xs btn-default" id="table1_fullScreen">
					<span class="glyphicon glyphicon-resize-full"></span>全屏显示
				</button>		
            </div>
			<div style="height:25%" id="panel1body1">
				<div class="col-lg-8" style="height:100%;overflow:hidden">
					<span style="color:red">
						<center><font size="+1">数据接口状态(Data Interface Status)</font></center>
					</span>
		 			<ul>
		 				<li>TCP/IP链路状态(Heart Beat Check)  <span class="pull-right"style="color:green">OK</span></li>
		 				<li>数据传输成功率(Data Trans Suc Rate) <span class="pull-right">100%</span></li>
		 				<li>数据平均传输速率(Data Trans Speed) <span class="pull-right" id="fileSpeed">400KB/S</span></li>
		 			</ul>
				</div>
				<div class="col-lg-4" style="height:100%;overflow:hidden">
					<span style="color:red">
						<center><font size="+2" >北斗授时</font></center>
					</span>
					<span style="color:red;-webkit-text-size-adjust: none;">
						<center><font size="+1" ><div id="txt"></div></font></center>
					</span>
				</div>				 
			</div>
			<br>
            <div style="width: 10px;height: 73%;overflow: hidden;" id="panel1body21">
				<div style="width: 40px;height:68%;overflow-y: hidden;"id="panel1body22">
					<ul id="ul1"></ul>
				</div>
			</div>
        </div>
	</div>
	
	<!-- 2.北斗短报文收发记录 -->
	<div class="center" >
		<div class="panel panel-warning" style="height:100%;width:100%">
	        <div class="panel-heading" style="cursor:default;">北斗短报文收发记录 
	        	<button type="button" class="pull-right btn btn-xs btn-default" id="form1_fullScreen">
	        		<span class="glyphicon glyphicon-resize-full"></span>全屏显示
	        	</button>		 
	            <button type="button" class="pull-right btn btn-xs btn-default" data-toggle="modal" data-target="#submitInfo">
	            	<span class="glyphicon glyphicon-send"></span>发送消息
	            </button>			
	        </div>
	        <div class="table-responsive">
				<table class="table">
				   <thead>
					  <col width='25%'>
					  <col width='15%'>
					  <col width='15%'>
					  <col width='15%'>
					  <col width='30%'>
				      <tr>
						  <th>时间</th>
						  <th>发送</th>
						  <th>接收</th>
						  <th>类型</th>
						  <th>内容</th>
				   	  </tr>
					</thead>					
				 </table>
				 </div>
				 <div class="panel-body" id="form1" style="overflow:hidden;height:75%;width:100%">
					<div class="table-responsive">
						<table class="table">
						   <col width='25%'>
						   <col width='15%'>
						   <col width='15%'>
						   <col width='15%'>
						   <col width='30%'>
						   <tbody id="form1_body"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
        <!-- 3.数据交换内容 -->
		<div class="right" >
			<div class="panel panel-warning" style="height:100%;width:100%" id="table2">
                <div class="panel-heading" id="heading">数据交换内容
	                <button type="button" class="pull-right btn btn-xs btn-default" id="table2_fullScreen">
	        			<span class="glyphicon glyphicon-resize-full"></span>全屏显示
	        		</button>	
                </div>
                <div class="table-responsive">
					<table class="table">
						<thead>
						    <col width='12%'>
							<col width='15%'>
							<col width='15%'>
							<col width='15%'>
							<col width='15%'>
							<col width='15%'>
							<tr>
								<th>卫星编号</th>
								<th>平近点角</th>
								<th>偏心率</th>
								<th>倾角</th>
								<th>近地点角距</th>
								<th>星历参照时刻</th>
							</tr>
						</thead>	
					</table>
				</div>         
                <div class="panel-body"	style="overflow:hidden;height:75%;width:100%">
                    <div class="table-responsive">
						<table class="table" id="mytable2">
							<col width='12%'>
						    <col width='15%'>
						    <col width='15%'>
						    <col width='15%'>
						    <col width='15%'>
						    <col width='15%'>
							<tbody id="table2_body"></tbody>
						</table>
					</div>
                </div>
            </div>
		</div>
	</div>
	
	<!-- 发送短报文弹出框 -->
	<div id="display" class="row"></div>
		<input id="dbNum_input" type="text" style="display:none" />
		<div class="modal fade" id="submitInfo" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="width:80%;height:50%;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="col-md-5 col-md-offset-3" style="background:rgba(33,30,30,1)">
					<div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			                  &times;
			            </button>
			            <h4 class="modal-title" id="myModalLabel">
			              	 发送消息
			            </h4>
			        </div>	
					<div class="panel-body" style="padding:20px 20px 20px 10px">
						<form role="form" id="sendMessageForm">
                           <fieldset>
                               <div class="form-group">
                                   <input type = "number" class="form-control" placeholder="接收终端号码" name="to" id="to" autofocus oninput="if(value.length>6)value=value.slice(0,6)">
                               </div>
                               <div class="form-group">
                                   <textarea class="form-control" rows="5" placeholder="消息内容" name="content" id="content" value=""></textarea>
                                  
                               </div>
                               <!-- Change this to a button or input when using this as a form -->                         
                               <a href="#" class="btn btn-lg btn-info btn-block btn-outline" id="SendMessage">发送消息</a>
                           </fieldset>
                       </form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
//set the clock in the table1
function startTime(){
	var today=new Date();
	var year=today.getFullYear();
	var month=today.getMonth()+1;
	var day = today.getDate();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	var ms=today.getMilliseconds();
	// add a zero in front of numbers<10
	m=checkTime(m);
	s=checkTime(s);
	ms=checkTime2(ms);
	document.getElementById('txt').innerHTML=year+"-"+month+"-"+day+"<br>"+h+":"+m+":"+s+"."+ms;
	t=setTimeout('startTime()',50);
}

function checkTime(i){
	if (i<10) {
		i = "0" + i;
	}
	return i;
}

function checkTime2(i){
	if (i<10) {
		i="00" + i;return i;
	}
	if (i<100) {
		i="0" + i;return i;
	}
	return i;
}

$("#SendMessage").click(function(){
	var content = encodeURI(document.getElementById("content").value);
	content = encodeURI(content);
	var url = "message/sendMessage?to="+$("#to").val()+"&content="+content;
	$("#submitInfo").modal('hide');
	document.getElementById("sendMessageForm").reset(); //清空原有的form里面input内容
	$.ajax({
		url:url,
		type:"post",
		dataType:"json",			
		success:function(msg){
			alert(msg.ok);
			if(msg.ok==true){
				alert("消息发送成功");
			 	update_table2();
			}
			else{
				alert("消息发送失败:" + msg.errorMsg);
			}
		},
		error:function(){ 
			alert("消息发送失败");
		}
	});
	
});

</script>