<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
   <title>Test Add Process</title>
</head>
<body>

<%!
	Statement s;
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
try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);
	
	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");
	
	    con = DriverManager.getConnection(url, uname, pass);
		s=con.createStatement();
		ResultSet rs = s.executeQuery("SELECT * FROM subject NATURAL JOIN course WHERE subject_id = "+request.getParameter("subjects"));
		rs.next();
		
		ResultSet rs1 = s.executeQuery("SELECT batch_id FROM batch where "+
		"batch_name = '"+request.getParameter("batch")+"' AND "+
		"course_id = "+rs.getInt("course_id")+";");
		rs1.next();
		
		s.executeUpdate("INSERT INTO test VALUES ("+
		request.getParameter("test_id")+
		","+request.getParameter("subjects")+
		","+rs1.getInt("batch_id")+
		","+request.getParameter("max_score")+
		","+ request.getParameter("faculty")+
		",'"+ request.getParameter("date_of_test")+
		"','"+ request.getParameter("time_of_test")+"');");
		%>
		<script>
swal("Test added!", "Test added successfully!", "success");
</script>
		<%con.close();
} catch(SQLException e) {
	System.out.println(e);
}
//response.sendRedirect("test_add.jsp");
%>
</body>
</html>