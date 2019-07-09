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
   
   String test_id = request.getParameter("id");

  ResultSet resultset = statement.executeQuery("  select * from student natural join test where test_id = '" + test_id + "'") ; 
   
  if(!resultset.next()  ) {
      out.println("Sorry, could not find that users. ");
  
  
   } else {  
	    
%>
 <table class="table table-dark">
		<tr>
			<th>Student Id</th><th>student Name</th>
			<th>Score</th>
		</tr>

   <% do {
       String student_id = resultset.getString("roll_no");
 %>
		<tr>
			<td><%= resultset.getString("roll_no") %>
			 </td>
		   <td><%= resultset.getString("first_name") %>  <%= resultset.getString("last_name") %></td>
		   <td>
		   <form method="post" action="addmarksservlet.java"> 
            <table border="1">
               <tr>
               <td><input type="text" name="score"></td>
                <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
               </tr>
		   </table>
		 	<input name ="test_id" value="<%=test_id %>"  type="hidden">
		 	<input name ="student_id" value="<%=student_id %>"  type="hidden">
		   </form>
		   </td>
		</tr>
<% }while(resultset.next());  %>		
		</table>
 <%
   }
 %> 

</body>
</html>