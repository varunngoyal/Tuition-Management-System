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
 <title>Admin - TimeTable delete results</title>
</head>
<body>
<%!
Statement s;
String course,batch;

String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
ResultSet student;
%>

<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

course = request.getParameter("course");
batch = request.getParameter("batch");  

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
    ResultSet rs = s.executeQuery("SELECT * FROM time_table WHERE batch_name = '"+batch+"' AND subject_id IN "+
    "(SELECT subject_id FROM subject WHERE course_id = "+course+")");    
    
    if(rs.next()) {
    
    s.executeUpdate("DELETE FROM time_table WHERE batch_name = '"+batch+"' AND subject_id IN "+
    "(SELECT subject_id FROM subject WHERE course_id = "+course+")");


%>
<script>
swal("Time Table deleted!", "Time Table removed successfully!", "success");
</script>
<% }else {
	%>
<script>
swal("Not found!", "Time Table not found!", "warning");
</script>	
<h1>Time Table not found</h1>	
	<%
}
   con.close(); //close connection
}
catch(Exception e)
{
    out.println(e);
}

//response.sendRedirect("student_delete.jsp");
%>
</body>
</html>