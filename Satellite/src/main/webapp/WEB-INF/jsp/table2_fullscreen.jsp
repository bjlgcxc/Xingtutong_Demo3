<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<link href="css/mybootstrap.min.css" rel="stylesheet">
	<link href="css/sb-admin-2.css" rel="stylesheet">
	<link href="css/dataTables.bootstrap.css" rel="stylesheet">
</head>

<body>
<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="dataTable_wrapper">
						<table class="table table-bordered table-hover" id="dataTables-example" style="border:1px solid #ddd">
							<thead>
								<tr>								
									<th>time</th>
									<th>from</th>
									<th>to</th>
									<th>type</th>
									<th>content</th>
								</tr>
							</thead>
							<tbody id="table2_body_fullscreen">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<script>
   $(document).ready(function() {
	   $.ajax({
			type : "get",
			dataType : "json",
			url : "message/getAllMessage",
			success : function(msg) { 
				var str = "";
				for(var i=msg.length-1;i>=0;i--){
					str = str + "<tr>" +
					"<td>" + GetDateTimeFormatStr(new Date(msg[i].time)) +"</td>"+
					"<td>" + msg[i].from +"</td>"+
					"<td>" + msg[i].to +"</td>"+
					"<td>" + msg[i].type +"</td>"+ 
					"<td>" + msg[i].content +"</td>"+
					"</tr>";
				}
				document.getElementById("table2_body_fullscreen").innerHTML = str;
				$('#dataTables-example').DataTable({
	               responsive: true,
	               aaSorting: [[1, "asc"]]
	       		});
			},
			error : function() {
				alert("failed");
			}
		});
	});

	function GetDateTimeFormatStr(date) {
		var seperator1 = "-";
		var seperator2 = ":";
		var month = date.getMonth() + 1;
		var hours = date.getHours();
		var minutes = date.getMinutes();
		var strDate = date.getDate();
		var seconds = date.getSeconds();
		if (month >= 1 && month <= 9) {
		    month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
		    strDate = "0" + strDate;
		}
		if(hours>=0 && hours<=9){
			hours = "0" + hours;
		}
		if(minutes>=0 && minutes<=9){
			minutes = "0" + minutes;
		}
		if(seconds>=0 && seconds<=9){
			seconds = "0" + seconds;
		}
		var formatDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + hours + seperator2 + minutes + seperator2 + seconds;
		
		return formatDate;
	}
</script>

</body>
</html>