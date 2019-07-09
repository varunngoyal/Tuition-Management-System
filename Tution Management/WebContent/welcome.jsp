<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

  response.setHeader("cache-control","no-cache,no-stores,must-revalidate");
  response.setHeader("pragma","no-cache");
 // response.set"WebContent/welcome.jsp"Header("Expires","0");
  if(session.getAttribute("username")==null)
  {
	   response.sendRedirect("login.jsp");
  }
%>
welcome ${username}
</body>

<form action ="Logout">

 <button type="submit">Logout</button>
</form>
</html>