<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<% Class.forName("com.mysql.jdbc.Driver");  %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fees Details</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
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
  
 
  ResultSet resultset = statement.executeQuery(" select * from batch natural join course;");

   
  if(!resultset.next()  ) {
	  {%>
		<script>
		swal("No result Found!!!");
		</script>
	<%}
  
  
   } else {  
            
	   
	   
   
%>

     <table class="table table-striped""  style= "margin: 30px 20px 0px 20px;">
  
		<tr>
			<th>Batch Id</th><th>Course</th>
			<th>Class</th><th>Batch</th><th>Fees Report</th>
		</tr>

   <% do {   	   String batch_id = resultset.getString("batch_id");
   %>
		<tr>
		   
			<td><%= resultset.getString("batch_id") %> </td>
		   <td><%= resultset.getString("course_name") %> </td>
		   <td><%= resultset.getString("class") %> </td>
		  <td><%= resultset.getString("batch_name") %> </td>
		<td><a href = "feesreport.jsp?id=<%=batch_id%>">view Report</a></td>
		</tr>
	
   
   <% }while(resultset.next());
   %>	
		</table>
  
   



 <%
   }
 %> 

</body>
</html>