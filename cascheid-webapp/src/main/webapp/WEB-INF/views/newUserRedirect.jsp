<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css?version=1.00" rel="stylesheet">
<title>CAScheid Games</title>
</head>
<body>
	<script>
	function saveNewUserData(){
		window.open("saveracinggame?identifier=${identifier}&sError=${sError}", "_self");
	}
	if ('create'=='${type}'){
		saveNewUserData();
	} else {
		window.open("gamesIndex?sError=${sError}", "_self");
	}
	</script>
</body>
</html>