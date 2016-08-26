$("#table1_fullScreen").click(function(event) {	
	var url = '<iframe src="table1_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>'	
	document.getElementById('display').innerHTML = url;
	document.getElementById("display").webkitRequestFullScreen();
});
$("#form1_fullScreen").click(function(event) {/*
	var form = document.getElementById("form1");
	form.webkitRequestFullScreen();
	$("#form1").css("background","rgba(0,0,0,1)");*/
	var url = '<iframe src="table2_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>'	
	document.getElementById('display').innerHTML = url;
	document.getElementById("display").webkitRequestFullScreen();
});
$("#table2_fullScreen").click(function(event) {
	/*var table = document.getElementById("table2");
 	mytable_width = $("#table2").width();
	table.webkitRequestFullScreen();
	$("#table2").width("90%");*/
	document.getElementById('display').innerHTML = '<iframe src="table3_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';
	document.getElementById("display").webkitRequestFullScreen();
	
});
$("#chart1_fullScreen").click(function(event) {
	var chart = document.getElementById("cesiumContainer1");
	$("#cesiumContainer1").height("100%");
	viewer1.animation.container.style.visibility="visible";
	viewer1.timeline.container.style.visibility="visible";
	chart.webkitRequestFullScreen();

});
$("#chart2_fullScreen").click(function(event) {
	var chart = document.getElementById("cesiumContainer2");
	chart.webkitRequestFullScreen();
	$("#cesiumContainer2").height("100%");
	viewer2.animation.container.style.visibility="visible";
	viewer2.timeline.container.style.visibility="visible";

});
$("#chart3_fullScreen").click(function(event) {
	/*var chart = document.getElementById("cesiumContainer3");	
	alert("fullscreen");
	chart.webkitRequestFullScreen();
	var width = screen.width + "px";
	var height = screen.height + "px";
	$("#cesiumContainer3").height(height);
	$("#cesiumContainer3").width(width);
	document.getElementById("skyFrame").contentWindow.myzoom();*/
	var url = '<iframe src="sky_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';
	document.getElementById('display').innerHTML = url;
	document.getElementById("display").webkitRequestFullScreen();

});