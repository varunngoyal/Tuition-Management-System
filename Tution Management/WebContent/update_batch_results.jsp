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
   <title>Update Batch Results</title>
</head>
<body>
<%!
	Statement s;
	String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;
	Connection con=null;
	
	String batch, course;
	int total_seats;
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

batch = request.getParameter("batch");
course = request.getParameter("course");
total_seats = Integer.parseInt(request.getParameter("total_seats"));

try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);
	
	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");
	
	    con = DriverManager.getConnection(url, uname, pass);
		s=con.createStatement();
		ResultSet rs = s.executeQuery("SELECT * FROM batch WHERE batch_name = '"+batch +"' AND course_id = "+course+";");
		rs.next();
		if(total_seats < rs.getInt("seats_occupied")) {%>
		<script>
swal("Failed updating batch!", "Batch size of <%=total_seats %> less than seats occupied i.e <%=rs.getInt("seats_occupied")%>!", "error");
</script>		
			
		<% }else {
		
		s.executeUpdate("UPDATE batch SET total_seats = "+total_seats+" WHERE "+
		"batch_name = '"+batch+"' AND course_id = "+course+";");
		
		%>
		<script>
swal("Batch updated!", "Batch size updated successfully!", "success");
</script>
		<%}con.close();
} catch(SQLException e) {
	System.out.println(e);
}
//response.sendRedirect("test_add.jsp");
%>
</body>
</html>
