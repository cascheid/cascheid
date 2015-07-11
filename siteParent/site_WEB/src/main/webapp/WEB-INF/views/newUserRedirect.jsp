<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css" rel="stylesheet">
<title>CScheid Games</title>
</head>
<body>
	<script>
	function saveNewUserData(){
		//if (window.XMLHttpRequest){
			window.open("saveracinggame?identifier=${identifier}&sError=${sError}", "_self");
			//window.open("gamesIndex?sError=${sError}", "_self");
			
			/*var req=new XMLHttpRequest();
			req.onreadystatechange = function() {
		        if (req.readyState == XMLHttpRequest.DONE ) {
		           if(req.status == 200){
		               alert(req.responseText);
		           }
		           else if(xmlhttp.status == 400) {
		              alert('There was an error 400')
		           }
		           else {
		               alert('something else other than 200 was returned')
		           }

		       		window.open("gamesIndex", "_self");
		        }
		    }
			req.open("POST","saveracinggame",false);
			req.send("identifier=${identifier}");
			*/
		
	}
	if ('create'=='${type}'){
		saveNewUserData();
	} else {
		window.open("gamesIndex?sError=${sError}", "_self");
	}
	</script>
	
</body>
</html>