var occurtime;
var occurtime1=null;
/*消息提示
 * 从下向上弹出数秒后弹出框自己收回
 * title 弹出框的名字
 * message 弹出框消息内容	
 */
function slide(title,message){
	$.messager.show({
		title:title,
		msg:message,
		showType:'show'
	});
	/*$.messager.show({
		title:title,
		msg:message,
		timeout:3000,
		showType:'slide',
		style:{
			right:'',
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});*/
}
function bottomright(title,message){
	$.messager.show({
		title:title,
		msg:message,
		showType:'show'
	});
}

/*alert弹框
 * title 弹出框的名字
 * message 弹出框消息内容
 */
function malert(title,message){
	$.messager.alert(title,message);
}
/*error弹框
 * title 弹出框的名字
 * message 弹出框消息内容
 */
function merror(title,message){
	$.messager.alert(title,message,'error');
}
/*info弹框
 * title 弹出框的名字
 * message 弹出框消息内容
 */
function minfo(title,message){
	$.messager.alert(title,message,'info');
}
/*question弹框
 * title 弹出框的名字
 * message 弹出框消息内容
 */
function mquestion(title,message){
	$.messager.alert(title,message,'question');
}
/*warning弹框
 * title 弹出框的名字
 * message 弹出框消息内容
 */
function mwarning(title,message){
	$.messager.alert(title,message,'warning');
}