<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				background:none transparent;
				padding:0;
				margin:0;
				font-weight: bold;
				overflow:hidden;
			}

			.menuitems {
				position: absolute;
				color: #ffffff;	
				text-decoration: none;
				padding-top: 5px;
				padding-bottom: 5px;
				padding-left: 15px;
				font-family:"Arial Black", Gadget, sans-serif;
				font-size:20px;
				display:inline-block;
				outline: 0;
			}
			
			#blitzMenu{
				position:absolute;
				top:20%;
				width:12%;
				height:190px;
				left:44%;
				background-color:#6B238E;
				background-image: url("img/cracks.png");
				border: 5px double white;
				display:none;
				padding:25px;
				z-index:1000;
			}

			a {	
				color: #ffffff;	
				text-decoration: none;
				padding-top: 5px;
				padding-bottom: 5px;
				padding-left: 15px;
				font-family:"Arial Black", Gadget, sans-serif;
				font-size:20px;
				display:inline-block;
				outline: 0;
			}
			
			#selector{
			position:absolute;
			left:5px;
			top:40px;
			width:40px;
			height:25px;
			}
			
			.selectedLink{
				color: #000000;	
			}
		</style>
	</head>

	<body>
		<div style="text-align:center">
			<label id="mainLabel" style="font-size:40px; font-weight:bold;">Create Your Blitzball Team</label>
		</div>
		<form:form id="teamForm" action="createBlitzball" commandName="teamName">
			<div style="text-align:center;">
			<div style="width:100%">
				<label id="noteLabel">Note: You can change your team name later.</label>
			</div>
			<div id="hometownDiv" style="display:inline; width:100%; font-size:26px; padding-bottom:40px;">
				<label>Enter hometown name:</label>
				<form:input path="town" />
			</div>
			<div style="width:100%; padding-top:5%">
				<label id="noteLabel" style="font-size:26px;">Choose your team name and logo:</label>
			</div>
			</div>
			<table style="vertical-align:center; width:100%; text-align:left; table-layout: fixed;">
				<tr>
					<td>
						<div style="display:inline-block; vertical-align:middle">
							<form:radiobutton path="mascot" value="Bandits" />Bandits
							<img src="img/blitzball/Bandits.jpg" style="vertical-align: middle;" width="120px" height="80px"></img>
						</div>
					</td>
					<td>
						<div style="display:inline-block; vertical-align:middle">
							<form:radiobutton path="mascot" value="Generals" />Generals
							<img src="img/blitzball/Bandits.jpg" style="vertical-align: middle;" width="120px" height="80px"></img>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display:inline-block; vertical-align:middle">
							<form:radiobutton path="mascot" value="Knights" />Knights
							<img src="img/blitzball/Bandits.jpg" style="vertical-align: middle;" width="120px" height="80px"></img>
						</div>
					</td>
					<td>
						<div style="display:inline-block; vertical-align:middle">
							<form:radiobutton path="mascot" value="Panthers" />Panthers
							<img src="img/blitzball/Bandits.jpg" style="vertical-align: middle;" width="120px" height="80px"></img>
						</div>
					</td>
				</tr>
			</table>
			<input type="submit" name="submit" value="Create Team!">
		</form:form>

	</body>
</html>
