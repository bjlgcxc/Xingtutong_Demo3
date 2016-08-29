function update_table3(element,num) {//update table3
	$.ajax({
		type : "get",
		dataType : "json",
		url : "Data/EpList/getEphemerisList?rows="+num+"&page=1",
		async:false,
		success : function(msg) {
			data = msg.rows;
			dbNum = msg.total;
			
	        $("#dbNum_input").val(dbNum);   
			//alert(data[0].ID);
			var str = "";
			for(var i=num-1;i >=0;i --){
				str = str + "<tr>"+
				"<td>"+data[i].satellitenumber +"&nbsp;&nbsp;&nbsp;</td>"+
				"<td>"+data[i].m0.toFixed(5) +"</td>"+
				"<td>"+data[i].e.toFixed(5) +"</td>"+
				"<td>"+data[i].i0.toFixed(5) +"</td>"+
				"<td>"+data[i].omega.toFixed(5) +"</td>"+
				"<td>"+data[i].toe +"</td>"+
					   "</tr>";
					   
			}
			element.innerHTML = str;
		},
		error : function() {
			alert("table_update1 failed");
			var str = "<tr>" + "<td>没有数据</td>"+ " </tr>";
			element.innerHTML = str;
		}
	});
}


function update_table2(){//update table2
	$.ajax({
		type : "get",
		dataType : "json",
		url : "message/getAllMessage",
		success : function(msg) { 
			var str = "";
			for(var i=msg.length-1;i >=0 ;i --){
				str = str + "<tr>"+
				"<td>"+GetDateTimeFormatStr(new Date(msg[i].time)) +"</td>"+
				"<td>"+msg[i].from +"</td>"+
				"<td>"+msg[i].to +"</td>";
				if(msg[i].type == "0"){
					str = str + "<td>接收</td>";		
				}
				else if(msg[i].type == "1"){
					str = str + "<td>发送</td>";			
				}
				if(msg[i].content.length > 10){
					str = str + "<td>"+msg[i].content.substr(0,10) +"......</td>"+
					   "</tr>";
				}
				else{
					
					str = str + "<td>"+msg[i].content +"</td>"+
					   "</tr>";
				}
			}
			document.getElementById("form1_body").innerHTML = str;
		},
		error : function() {
			alert("failed");
		}
	});
}


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
		hours = "0"+hours;
	}
	if(minutes>=0 && minutes<=9){
		minutes = "0"+minutes;
	}
	if(seconds>=0 && seconds<=9){
		seconds = "0"+seconds;
	}
	var formatDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + hours + seperator2 + minutes + seperator2 + seconds;
	
	return formatDate;
}


function getDateRateForNext24Hours() {//get time from now to the next 24 hours

	var currentDate = new Date();

	var fullYear = currentDate.getFullYear();
	var month = addZero(currentDate.getMonth() + 1);
	var day = addZero(currentDate.getDate());

	hour = addZero(currentDate.getHours());
	minute = addZero(currentDate.getMinutes());
	second = addZero(currentDate.getSeconds());

	//var res = "sats=36287,36590,36828,37210,37256,37384,37763,37948,38091,38250,38251,38775,38953,40549,40748,40749,40938,41315,41434,41586";
	var res = "sats=36287,36590,36828,37210,37256,37384,37763,37948,38091,38250,38251,38775,38953,40549,40748,40749,40938,41315,41434,41586";
	res = res + "&start=" + fullYear + "-" + month + "-" + day + "_" + hour
			+ ":" + minute + ":" + second;

	day = currentDate.getDate();
	month = currentDate.getMonth() + 1;

	if (day == 29 && month == 2) {
		day = "01";
		month = "03"
	} else if (day == 30
			&& (month == 9 || month == 4 || month == 6 || month == 11)) {
		day = "01";
		month = addZero(month + 1);
	} else if (day == 31 && month == 12) {
		day = "01";
		month = "01"
		year = fullYear + 1;
	} else if (day == 31) {
		day = "01";
		month = addZero(month + 1);
	} else {
		day = addZero(day + 1);
		month = addZero(month);
	}

	res = res + "&end=" + fullYear + "-" + month + "-" + day + "_" + hour
			+ ":" + minute + ":" + second + "&format=czml&type=orbit";

	function addZero(i) {
		if (i < 10) {
			i = "0" + i;
		}
		return i;
	}
	return res;
}

function update_viewer(){//get data from API for viewer
	var date = getDateRateForNext24Hours();
	var url = "CZML/getCzmlDataSource?" + date;
	$.ajax({
		type : "get",
		dataType : "json",
		url : url,
		success : function(msg) {
			viewer1.dataSources.add(Cesium.CzmlDataSource.load(msg));
			viewer2.dataSources.add(Cesium.CzmlDataSource.load(msg)); 
		},
		error:function(){
			viewer1.dataSources.add(Cesium.CzmlDataSource.load("data/OrbitData.txt"));
			viewer2.dataSources.add(Cesium.CzmlDataSource.load("data/OrbitData.txt")); 
		}
	});
}

function update_table1() {
	$.ajax({
		type : "get",
		dataType : "json",
		async : false,
		url : "datalog/getDataLog",
		success : function(msg) {
			var str = "";
			for ( var i = 0, j = 0; j < 20; i++, j++) {
				str = str + "<li class='news-item'>"
						+ "dataFormat:" + msg[i].dataFormat
						+ "|dataSize:" + msg[i].dataSize + "|type:"
						+ msg[i].type + "|status:" + msg[i].status
						+ "|time:" + msg[i].time;
				if (msg[i].type == "1") {
					str = str
							+ "|<span style='color:green'>response</span></li>";
				} else {
					str = str
							+ "|<span style='color:red'>recieve</span></li>";
				}
			}
			document.getElementById("ul1").innerHTML = str;
			$("#ul1").bootstrapNews({
				newsPerPage : 10,
				autoplay : true,
				pauseOnHover : false,
				navigation : false,
				direction : 'down',
				newsTickerInterval : 5000,
				onToDo : function() {
					//console.log(this);
				}
			});
		},
		error : function() {
			alert("获取数据失败");
		}
	}); //1

}

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

