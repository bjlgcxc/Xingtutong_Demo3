<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="row">

	<!-- 1.北斗卫星轨道3D展示 -->
	<div class="col-lg-4">
		<div class="panel panel-info" id="id11">
			<div class="panel-heading">北斗卫星轨道3D展示
				<button type="button" class="pull-right btn btn-xs btn-default" id="chart1_fullScreen">
	        		<span class="glyphicon glyphicon-resize-full"></span>全屏显示
	        	</button>	 
			</div>
			<div class="panel-body" id="id1" style="height:100%;width:100%">
				<div id="cesiumContainer1" style="height:100%;width:100%"></div>
				<script>
					var extent = Cesium.Rectangle.fromDegrees(95.3,39.9,97.313421,40.1);
		
					Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
					Cesium.Camera.DEFAULT_VIEW_FACTOR = 5;

					var viewer1 = new Cesium.Viewer('cesiumContainer1', {
						baseLayerPicker : false,
						fullscreenButton : false,
						sceneModePicker : false,
						geocoder : false,
						navigationHelpButton : false,
						sceneMode : Cesium.SceneMode.SCENE3D,
					});
					viewer1.animation.container.style.visibility="hidden";
					viewer1.timeline.container.style.visibility="hidden";
				</script>
			</div>
		</div>
	</div>	
	
	<!-- 2.北斗卫星轨道2D展示 -->
	<div class="col-lg-4">
		<div class="panel panel-danger">
			<div class="panel-heading">北斗卫星轨道2D展示
				<button type="button" class="pull-right btn btn-xs btn-default" id="chart2_fullScreen">
	        		<span class="glyphicon glyphicon-resize-full"></span>全屏显示
	        	</button>	
			</div>
			<div class="panel-body">
				<div id="cesiumContainer2" style="height:100%;width:100%"></div>
				<script>
					var extent = Cesium.Rectangle.fromDegrees(95.3,0,97.313421,1);
	
					Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
					Cesium.Camera.DEFAULT_VIEW_FACTOR = 6;

					var viewer2 = new Cesium.Viewer('cesiumContainer2', {
						baseLayerPicker : false,
						fullscreenButton : false,
						sceneModePicker : false,
						geocoder : false,
						navigationHelpButton : false,
						sceneMode : Cesium.SceneMode.SCENE2D,
					});
					viewer2.animation.container.style.visibility="hidden";
					viewer2.timeline.container.style.visibility="hidden";
					
					var extent = Cesium.Rectangle.fromDegrees(95.3,39.9,97.313421,40.1);
					Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
					Cesium.Camera.DEFAULT_VIEW_FACTOR = 5;
				</script>
			</div>
		</div>
	</div>

	<!-- 3.北斗卫星投影展示  -->
	<div class="col-lg-4">
		<div class="panel panel-warning">
			<div class="panel-heading">北斗卫星投影展示 
				<button type="button" class="pull-right btn btn-xs btn-default" id="chart3_fullScreen">
	        		<span class="glyphicon glyphicon-resize-full"></span>全屏显示
	        	</button>	
			</div>
			<div class="panel-body" style="height:100%;width:100%" id="cesiumContainer3">
		 		<iframe src="sky.html " width="100%" height="100%" id="skyFrame" name="skyFrame"  frameborder="no" scrolling="no"></iframe>
			</div>
		</div>
	</div>
</div>
