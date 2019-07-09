<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%> 
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!

Statement s = null;
ResultSet student_details;

String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%> 
<%
Connection con=null;
try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);
	
	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");
	
	    con = DriverManager.getConnection(url, uname, pass);
		s=con.createStatement();
		student_details = s.executeQuery("SELECT * FROM student WHERE roll_no = " + session.getAttribute("uname"));

}catch(SQLException e) {
	System.out.println(e.getErrorCode());
}	
  response.setHeader("cache-control","no-cache,no-stores,must-revalidate");
  response.setHeader("pragma","no-cache");
  response.setHeader("Expires","0");
  if(session.getAttribute("username")==null)
  {
	   response.sendRedirect("login.jsp");
  }
%>
welcome <%=student_details.getInt("roll_no")%>,
</body>

<form action ="Logo">

 <button type="submit">Logout</button>
</form>
</html>