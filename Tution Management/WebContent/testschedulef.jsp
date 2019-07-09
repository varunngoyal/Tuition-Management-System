<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<% Class.forName("com.mysql.jdbc.Driver");  %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Test List</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>


<body>
<%!
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
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
  Statement statement = con.createStatement();
            
  String uname = (String)session.getAttribute("uname");

 
 ResultSet resultset = statement.executeQuery(" select test_id ,class , course_name ,batch_name,subject_name,date,time,max_score from test natural join batch natural join subject  natural join  course where faculty_id = '" + uname + "'") ;
   
  if(!resultset.next()  ) {
      out.println("Sorry, could not find that users. ");
  
  
      
   } else {  
            
	   
	   
   
%>
   <table class="table table-striped""  style= "margin: 30px 20px 0px 20px;">

		<tr>
			<th>Test  Serial No</th><th>class</th>
			<th>Course</th><th>Batch</th><th>Subject</th>
			<th>Test date</th><th>Test time</th><th>Maximum Marks</th>
		</tr>

   <% do {   	   String test_id = resultset.getString("test_id");
   %>
		<tr>
		   
			<td><%= resultset.getString("test_id") %> </td>
		   <td><%= resultset.getString("class") %> </td>
		   <td><%= resultset.getString("course_name") %> </td>
		  <td><%= resultset.getString("batch_name") %> </td>
		<td><%= resultset.getString("subject_name") %> </td>
		  <td><%= resultset.getString("date") %> </td>
		  <td><%= resultset.getString("time") %> </td>
		<td><%= resultset.getString("max_score") %> </td>  
		</tr>
	
   
   <% }while(resultset.next());
   %>	
		</table>
  
   



 <%
   }
 %> 

</body>
</html>