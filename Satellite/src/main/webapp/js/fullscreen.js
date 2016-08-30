var webkit = /webkit/.test(navigator.userAgent.toLowerCase());  
var msie = /msie/.test(navigator.userAgent.toLowerCase()) || /trident/.test(navigator.userAgent.toLowerCase());  
var mozilla = /firefox/.test(navigator.userAgent.toLowerCase());

//全屏函数(根据不同的浏览器类型)
function fullScreen(element){
	if(webkit){
		element.webkitRequestFullScreen();
	}
	else if(msie){
		element.msRequestFullscreen();
	}
	else if(mozilla){
		element.mozRequestFullScreen();
	}
}


/*数据交换日志*/
$("#table1_fullScreen").click(function(event) {	
	var url = '<iframe src="table1_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';	
	document.getElementById('display').innerHTML = url;
	fullScreen(document.getElementById('display'));
});

/*短报文收发*/
$("#form1_fullScreen").click(function(event) {
	var url = '<iframe src="table2_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';	
	document.getElementById('display').innerHTML = url;
	fullScreen(document.getElementById('display'));	
});

/*数据交换内容*/
$("#table2_fullScreen").click(function(event) {
	document.getElementById('display').innerHTML = '<iframe src="table3_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';
	fullScreen(document.getElementById('display'));
});

/*卫星3D*/
$("#chart1_fullScreen").click(function(event) {
	var chart = document.getElementById("cesiumContainer1");
	$("#cesiumContainer1").height("100%");
	viewer1.animation.container.style.visibility="visible";
	viewer1.timeline.container.style.visibility="visible";
	fullScreen(chart);
});

/*卫星2D*/
$("#chart2_fullScreen").click(function(event) {
	var chart = document.getElementById("cesiumContainer2");
	$("#cesiumContainer2").height("100%");
	viewer2.animation.container.style.visibility="visible";
	viewer2.timeline.container.style.visibility="visible";
	fullScreen(chart);
});

/*卫星投影*/
$("#chart3_fullScreen").click(function(event) {
	var url = '<iframe src="sky_fullscreen.html" style="width:'+screen.width+'px;height:'+screen.height+'px;border:0px"></iframe>';
	document.getElementById('display').innerHTML = url;
	fullScreen(document.getElementById('display'));
});