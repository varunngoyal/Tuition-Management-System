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
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> 
   <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
   
   <style>
   
   
      #someid tr td:nth-child(1){
      width:30%;
}

    #idh {
   height: 200px;
}


   
   </style>
</head>

<body>
<%!

String url,uname, pass,batch_name,subject_name;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
float passing_marks ,maximum_marks;
int class_name;
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
   
   
   
 ResultSet rs3 = statement.executeQuery(" select test_id ,class , course_name ,batch_name,subject_name,date,time,max_score from test natural join batch natural join subject  natural join  course where test_id = '" + test_id + " ' ");

   if(rs3.next())
   {
      subject_name = rs3.getString("subject_name");
      class_name = rs3.getInt("class");
      batch_name = rs3.getString("batch_name");
   }
   
   ResultSet rs = statement.executeQuery("select * from test where test_id = ' " + test_id + " ' ");
   
   if(rs.next())
   {
	   maximum_marks = rs.getFloat("max_score");
	   System.out.println(maximum_marks);
	   
	   passing_marks = 40* maximum_marks/100;
	   System.out.println(passing_marks);

   }

  ResultSet resultset = statement.executeQuery("  select max(score) as maximum , first_name,last_name,student_id  from test_results natural join student  where test_id = '" + test_id + "' and student_id = roll_no") ; 
   
  if(!resultset.next()  ) {
	  {%>
		<script>
		swal("No result found!", "Test marks are not uploaded!", "error");
		</script>
	<%} 
  
  
   } else {  
	    
%>     

    <h4><center>Test Report of <%=class_name %>th  <%=subject_name %> for <%=batch_name %> batch</center></h4>
                  <br>
                  <h5><center>Toppers</center></h5>
       
      <table class="table table-bordered table-striped" style= "margin: 30px 20px 0px 20px;">
		<tr>
			<th>Roll No</th><th>student Name</th>
			<th>Score</th>
		</tr>

   <% do {
      
 %>
		<tr>
			<td><%= resultset.getString("student_id") %>
			 </td>
		   <td><%= resultset.getString("first_name") %>  <%= resultset.getString("last_name") %></td>
		   <td><%= resultset.getString("maximum") %>
			 </td>
	 </tr>
		   
		 
<% }while(resultset.next());  %>		
		</table>
   



 <%
   }
 %> 
 
 <%   ResultSet rs1 = statement.executeQuery("  select score , first_name,last_name,student_id  from test_results natural join student  where test_id = '" + test_id + "' and score >= ' " + passing_marks + " ' and student_id = roll_no ") ; 
 
  if(!rs1.next()  ) {
      
  
  
   } else {  
	    
%>     
                  <br>
                  <h5><center>Passed Student</center></h5>
       
      <table class="table table-bordered table-striped" style= "margin: 30px 20px 0px 20px;">
		<tr>
			<th>Roll No</th><th>student Name</th>
			<th>Score</th>
		</tr>

   <% do {
      
 %>
		<tr>
			<td><%= rs1.getString("student_id") %>
			 </td>
		   <td><%= rs1.getString("first_name") %>  <%= rs1.getString("last_name") %></td>
		   <td><%= rs1.getString("score") %>
			 </td>
	 </tr>
		   
		 
<% }while(rs1.next());  %>		
		</table>
   



 <%
   }
 %> 
 
 
 
 <%   ResultSet rs2 = statement.executeQuery("select score , first_name,last_name,student_id  from test_results natural join"+
 " student  where test_id = " + test_id + " and score < "+passing_marks+" and student_id = roll_no"); 
 
  if(!rs2.next()  ) {
      
  
  
   } else {  
	    
%>     
                  <br>
                  <h5><center>Failed  Student</center></h5>
       
      <table class="table table-bordered table-striped" style= "margin: 30px 20px 0px 20px;">
		<tr>
			<th>Roll No</th><th>student Name</th>
			<th>Score</th>
		</tr>

   <% do {
      
 %>
		<tr>
			<td><%= rs2.getString("student_id") %>
			 </td>
		   <td><%= rs2.getString("first_name") %>  <%= rs2.getString("last_name") %></td>
		   <td><%= rs2.getString("score") %>
			 </td>
	 </tr>
		   
		 
<% }while(rs2.next());  %>		
		</table>
   



 <%
   }
 %> 

<%
ResultSet rs4 = statement.executeQuery("  select count(student_id) as pass  from test_results  where test_id = '" + test_id + "' and  score  >= ' " + passing_marks + " ' ") ; 

if( rs4.next())
{
%>
  
<br><br>
<h5><center>Test Statistics</center></h5>

<div class="container" >
  <div  class="col-md-offset-2" class="row col-md-8">
 
  <div  style = "background-color: white">       
  <table class="table table-bordered"  id="someid">
      
   
    <tbody>
      <tr>
        <td>Passed Student</td>
        <td><%=rs4.getString("pass")%></td>
      
      </tr>
<%
}
%>

<%
ResultSet rs5 = statement.executeQuery("  select count(student_id) as fail  from test_results  where test_id = '" + test_id + "' and  score  < ' " + passing_marks + " ' ") ; 

if( rs5.next())
{
%>
  


<div class="container" >
  <div  class="col-md-offset-2" class="row col-md-8">
 
 
      <tr>
        <td>Failed Student</td>
        <td><%=rs5.getString("fail")%></td>
      
      </tr>
<%
}
%>
    
</tbody>
</table>



</body>
</html>