<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.identity.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Site</title>
</head>
<body>
	<iframe name="topFrame" width="100%" height="150px" src="topframe?identifier=${identifier}"></iframe>
	<iframe name="leftFrame" width="20%" height="650px" src="leftframe?identifier=${identifier}"></iframe>
	<iframe name="displayFrame" width="78%" height="650px" src="displayframe?identifier=${identifier}"></iframe>
</body>
</html>