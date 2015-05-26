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
	<jsp:useBean id="identity" class="site.identity.Identity" scope="session"/>
	<jsp:setProperty name="identity" property="*"/> 
	<%
		String identifier = null;
   		Cookie cookie = null;
   		Cookie[] cookies = null;
   		// Get an array of Cookies associated with this domain
   		cookies = request.getCookies();
   		if( cookies != null ){
      		for (int i = 0; i < cookies.length; i++){
         		cookie = cookies[i];
         		if (cookie.getName().equals("identifier")){
         			identity = IdentityUtils.getIdentityByIdentifier(Long.parseLong(cookie.getValue()));
         		}
      		}
  		}
   		if (identity==null){
      		identity = new Identity();
      	   	Cookie newCookie = new Cookie("identifier", identity.getIdentifier().toString());

      	   // Set expiry date after 24 Hrs for both the cookies.
      	   //identifier.setMaxAge(60*60*24); 

      	   // Add both the cookies in the response header.
      	   response.addCookie(newCookie);
  		}
   		identifier=identity.getIdentifier().toString();
	%>
	<iframe name="topFrame" width="100%" height="150px" src="topFrame.jsp?identifier=<%=identifier%>"></iframe>
	<iframe name="leftFrame" width="20%" height="650px" src="leftFrame.jsp?identifier=<%=identifier%>"></iframe>
	<iframe name="displayFrame" width="78%" height="650px" src="displayFrame.jsp?identifier=<%=identifier%>"></iframe>
</body>
</html>