<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Parent delete process</title>
</head>
<body>
<%!
Statement s;
String[] p_id;

String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

Connection con = null;
p_id = request.getParameterValues("selected_records");
try
{
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
        
    s = con.createStatement();
    for(int i=0; i<p_id.length; i++) 	
		s.executeUpdate("DELETE FROM parent WHERE p_id = "+p_id[i]+";");
%>

<%     	
   con.close(); //close connection
}
catch(Exception e)
{
    out.println(e);
}
response.sendRedirect("parent_delete.jsp");
%>
</body>
</html>