<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?test=3"/>
<style>
	body{overflow:hidden; border:0px; margin:0px; padding:0px;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<iframe id="centerUpgradeFrame" name="centerUpgradeFrame" width="19%" src="upgradeStoreFrame" frameBorder="0" style="visibility:hidden" onload="this.style.visibility='visible';"></iframe>
	<iframe id="rightUpgradeFrame" name="rightUpgradeFrame" width="79%" src="upgradeDisplayFrame" frameBorder="0" style="visibility:hidden" onload="this.style.visibility='visible';"></iframe>
	<script>
	document.onreadystatechange = function(e){
	    if (document.readyState === 'complete'){
			document.getElementById('centerUpgradeFrame').height=(window.innerHeight)+'px';
			document.getElementById('rightUpgradeFrame').height=(window.innerHeight)+'px';
	    }
	};
	</script>
</body>
</html>