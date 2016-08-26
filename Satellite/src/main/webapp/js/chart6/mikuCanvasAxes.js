//Classes----------------------------------------------------
function mikuLoc(locX,locY){
    this.x = locX;
    this.y = locY;
}
//Contents---------------------------------------------------
var GRID_STYLE  = "lightgray",
    GRID_LINE_WIDTH = 0.5;

var AXES_STYLE  = "#a2a2a2",
    AXES_LINE_WIDTH = 1,
    VERTICAL_TICK_SPACING = 10,
    HORIZONTAL_TIKE_SPACING = 10,
    TICK_WIDTH = 10;
//Function---------------------------------------------------
//绘制网格
//传入参数为：绘图环境,x轴间隔，y轴间隔
function drawGrid(context,stepx,stepy){
    context.save();
    context.strokeStyle = GRID_STYLE;
    //设置线宽为0.5
    context.lineWidth   = GRID_LINE_WIDTH;
    //绘制x轴网格
    //注意：canvas在两个像素的边界处画线
    //由于定位机制，1px的线会变成2px
    //于是要+0.5
    stepx=5;
    strpy=10;
    for(var i=stepx+0.5;i<context.canvas.width;i=i+stepx){
        //开启路径
        context.beginPath();
        context.moveTo(i,0);
      //  context.lineTo(i,context.canvas.height);
        context.stroke();
        }
        //绘制y轴网格
    for(var i=stepy+0.5;i<context.canvas.height;i=i+stepy){
        context.beginPath();
        context.moveTo(0,i);
    //    context.lineTo(context.canvas.width,i);
        context.stroke();
        }
    context.restore();
};
//Function---------------------------------------------------
//绘制坐标轴
//传入参数为：绘图环境,坐标轴边距
function drawAxes(context,axesMargin){
    //保存样式
    context.save();
    var originLoc = new mikuLoc(axesMargin, context.canvas.height-axesMargin);
    var axesW = context.canvas.width  - (axesMargin*2),
        axesH = context.canvas.height - (axesMargin*2);
    //设置坐标绘图样式绘图样式
    context.strokeStyle   =  AXES_STYLE;
    context.lineWidth =   AXES_LINE_WIDTH;
    //绘制x,y轴
    drawHorizontalAxis();
    drawVerticalAxis();
    drawVerticalAxisTicks();
    drawHorizontalAxisTicks();
    //恢复样式
    context.restore();
    
    //绘制x轴
    function drawHorizontalAxis(){
        context.beginPath();
        context.moveTo(originLoc.x, originLoc.y);
   //     context.lineTo(originLoc.x + axesW, originLoc.y);
        context.stroke();
    }
    //绘制y轴
    function drawVerticalAxis(){
        context.beginPath();
        context.moveTo(originLoc.x, originLoc.y);
    //    context.lineTo(originLoc.x, originLoc.y - axesH);
        context.stroke();
    }
    //绘制垂直轴小标标
    function drawVerticalAxisTicks(){
        var deltaX;
        //当前垂直tick的y轴坐标
        var nowTickY =originLoc.y-VERTICAL_TICK_SPACING;
        for(var i=1;i<=(axesH/VERTICAL_TICK_SPACING);i++){
            if(i%5 === 0){
                deltaX=TICK_WIDTH;
            }else {
                deltaX=TICK_WIDTH/2;   
            }
            context.beginPath();
            //移动到当前的tick起点
            context.moveTo(originLoc.x-deltaX,nowTickY);
//            context.lineTo(originLoc.x+deltaX,nowTickY);
            context.stroke();
            nowTickY=nowTickY-VERTICAL_TICK_SPACING;
        }
    }
    //绘制水平轴小标标
    function drawHorizontalAxisTicks(){
        var deltaY;
        var nowTickX = originLoc.x+HORIZONTAL_TIKE_SPACING;
         for(var i=1;i<=(axesW/HORIZONTAL_TIKE_SPACING);i++){
            if(i%5 === 0){
                deltaY = TICK_WIDTH;
            }else{
                deltaY = TICK_WIDTH/2;   
            }
            context.beginPath();
            context.moveTo(nowTickX,originLoc.y+deltaY);
 //           context.lineTo(nowTickX,originLoc.y-deltaY);
            context.stroke();
            nowTickX = nowTickX + HORIZONTAL_TIKE_SPACING;
        }
    }
};
//Function---------------------------------------------------
//绘制中心坐标轴
//传入参数为：绘图环境,坐标轴边距
function drawCenterAxes(context,axesMargin){
  //保存样式
  context.save();
  var originLoc = new mikuLoc(context.canvas.width/2, context.canvas.height/2);
  var axesW = context.canvas.width  - (axesMargin*2),
      axesH = context.canvas.height - (axesMargin*2);
  //设置坐标绘图样式绘图样式
  context.strokeStyle   =  AXES_STYLE;
  context.lineWidth =   AXES_LINE_WIDTH;
	context.beginPath(); 
    context.arc(originLoc.x, originLoc.y, axesH/2, 0, Math.PI*2, true); 
    context.lineWidth = 1.0; 
    context.fillStyle = "#C4DFF3"; 
	context.fill();
	  //绘制x,y轴
	  drawHorizontalAxis();
	  drawVerticalAxis();
	  drawVerticalAxisTicks();
	  drawHorizontalAxisTicks();
 
  //恢复样式
  context.restore();
  
  //绘制x轴
  function drawHorizontalAxis(){
      context.beginPath();
      context.moveTo(axesMargin, originLoc.y);
//      context.lineTo(axesMargin + axesW, originLoc.y);
      context.stroke();
  }
  //绘制y轴
  function drawVerticalAxis(){
      context.beginPath();
      context.moveTo(originLoc.x, axesMargin);
 //     context.lineTo(originLoc.x, axesMargin + axesH);
      context.stroke();
  }
  //绘制垂直轴小标标
  function drawVerticalAxisTicks(){
      var deltaX;
      //当前垂直tick的y轴坐标
      var nowTickY =originLoc.y-VERTICAL_TICK_SPACING;
      for(var i=1;i<=(axesH/VERTICAL_TICK_SPACING/2);i++){
          if(i%5 === 0){
              deltaX=TICK_WIDTH;
          }else {
              deltaX=TICK_WIDTH/2;   
          }
          context.beginPath();
          //移动到当前的tick起点
          context.moveTo(originLoc.x-deltaX,nowTickY);
 //         context.lineTo(originLoc.x+deltaX,nowTickY);
          context.stroke();
          nowTickY=nowTickY-VERTICAL_TICK_SPACING;
      }
      
      nowTickY =originLoc.y+VERTICAL_TICK_SPACING;
      for(var i=1;i<=(axesH/VERTICAL_TICK_SPACING/2);i++){
          if(i%5 === 0){
              deltaX=TICK_WIDTH;
          }else {
              deltaX=TICK_WIDTH/2;   
          }
          context.beginPath();
          //移动到当前的tick起点
          context.moveTo(originLoc.x-deltaX,nowTickY);
          context.lineTo(originLoc.x+deltaX,nowTickY);
 //         context.stroke();
          nowTickY=nowTickY+VERTICAL_TICK_SPACING;
      }
  }
  //绘制水平轴小标标
  function drawHorizontalAxisTicks(){
      var deltaY;
      var nowTickX = originLoc.x+HORIZONTAL_TIKE_SPACING;
       for(var i=1;i<=(axesW/HORIZONTAL_TIKE_SPACING/2);i++){
          if(i%5 === 0){
              deltaY = TICK_WIDTH;
          }else{
              deltaY = TICK_WIDTH/2;   
          }
          context.beginPath();
          context.moveTo(nowTickX,originLoc.y+deltaY);
 //         context.lineTo(nowTickX,originLoc.y-deltaY);
          context.stroke();
          nowTickX = nowTickX + HORIZONTAL_TIKE_SPACING;
      }
       
      nowTickX = originLoc.x - HORIZONTAL_TIKE_SPACING;
       for(var i=1;i<=(axesW/HORIZONTAL_TIKE_SPACING/2);i++){
          if(i%5 === 0){
              deltaY = TICK_WIDTH;
          }else{
              deltaY = TICK_WIDTH/2;   
          }
          context.beginPath();
          context.moveTo(nowTickX,originLoc.y+deltaY);
 //         context.lineTo(nowTickX,originLoc.y-deltaY);
          context.stroke();
          nowTickX = nowTickX - HORIZONTAL_TIKE_SPACING;
      }
  }
};
