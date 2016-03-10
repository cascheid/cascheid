<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				background:#000;
				padding:0;
				margin:0;
				font-weight: bold;
				overflow:hidden;
			}
		#blitzMenuFrame{
			position:absolute;
			left:0;
			top:0;
			width:100%; 
			height:100%; 
			overflow:hidden;
		}
	</style>
	</head>

	<body style="margin:0px;padding:0px;overflow:hidden">
		
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r71/three.min.js"></script>
		 -->
		<script src="js/three.js"></script>
		<script src="js/FresnelShader.js"></script>

		<script src="js/Detector.js"></script>

		<script src="js/DDSLoader.js"></script>
		<script src="js/MTLLoader.js"></script>
		<script src="js/OBJMTLLoader.js"></script>
		<script src="js/BBAnimation.js"></script>
		<script src="js/AnimationHandler.js"></script>
		<script src="js/KeyFrameAnimation.js"></script>
		<script src="js/ColladaLoader.js"></script>
		<script src="js/blitzballMenu.js?version=0.1"></script>

		<iframe id="blitzMenuFrame" name="blitzMenuFrame" frameborder=0 height="100%" width="100%" src="bbTestExpiringContracts" allowtransparency="true" onload="focusFrame()"></iframe>
		
		<script>
		function focusFrame(){
			document.getElementById('blitzMenuFrame').focus();
		}
		</script>
	</body>
</html>
