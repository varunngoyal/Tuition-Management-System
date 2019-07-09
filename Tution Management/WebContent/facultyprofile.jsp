<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<% Class.forName("com.mysql.jdbc.Driver");  %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Faculty Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <style>
      #someid tr td:nth-child(1){
      width:30%;
}

    #idh {
   height: 200px;
}

body {
background-color: #DCDCDC;}

 </style>


</head>

<body>
<%!
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%>
 <%@page import="java.util.Base64"%>
 
      <%  
        
        Blob image = null;

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
%>


<div class="container" >
  <div  class="col-md-offset-2" class="row col-md-8">
  
  <div  style = "background-color: white">    
  <div  style="border:2px solid black"  id="someid">   
  <table class="table table-bordered">
  
   <%

ResultSet  rs2= statement.executeQuery("select * from faculty_image  where faculty_id = ' " +uname +" ' ");
   if( rs2.next())
 {
	 %>
 <tr id = "idh"> <td><h4> Profile Photo</h4></td>
<td><img  src = "data:image/png;base64,<%=Base64.getEncoder().encodeToString(rs2.getBytes("faculty_image")) %>"
  style =" width : 200px; height : 200px; border: 2px solid black" >
 </td></tr>
  <%
  } 
%>
      
      
 <tr><td><h4> Personal Detail</h4></td><td></td></tr>
 <tbody>
 <%  ResultSet resultset = statement.executeQuery("select * from faculty where  faculty_id = '" + uname + "'") ;  
       if(resultset.next()) {
 %>  

  <tr>
        <td>Faculty Id</td>
        <td><%= resultset.getString("faculty_id") %></td>
      </tr>
      <tr>
 	<td>Name</td>
     <td><%= resultset.getString("first_name") %>   <%= resultset.getString("last_name") %></td> 
     </tr>
     <tr>
	<td>Gender</td>
	<td><%= resultset.getString("gender") %></td>
     </tr>
     <tr>
	<td>DOB</td>
	<td><%= resultset.getString("dob") %></td>
     </tr>
     <tr>
	<td>Mobile No.</td>
	<td><%= resultset.getString("mobile_no") %></td>
     <tr>
	<td>Address</td>
	<td><%= resultset.getString("address") %></td>
	
	<%  }
       
	%>
     <tr><td><h4> Professional Detail</h4></td><td></td></tr>
     
     
<%
ResultSet resultset1 = statement.executeQuery("select * from faculty_qualification  where  faculty_id = '" + uname + "'") ;  
if(resultset1.next()) {

%> 
     <tr>
     	<td>Qualification</td>
        <td><%= resultset1.getString("qualification") %></td>
     </tr>
  <%  }


ResultSet resultset2 = statement.executeQuery("select * from faculty  where  faculty_id = '" + uname + "'") ;  
if(resultset2.next()) {

  %>
  
  <tr>
  <td>Year of Experiences</td>
	<td><%= resultset2.getString("years_of_exp") %></td>
	</tr>
	
	
</tbody>
</table>


	<%   }


%>

 <table class="table table-bordered" >

<tbody>
<%
ResultSet rs3 = statement.executeQuery("select * from faculty_subject natural join subject where  faculty_id = '" + uname + "'");  
if(rs3.next()) {
    
do{
%>
    <tr>
	<td>Subject</td>
	<td><%= rs3.getString("subject_name") %></td>
   </tr>
<%  }while(rs3.next()); 
  }
  con.close();%>       
  
</tbody>
</table>
</div>
</div>
</div>
</div>

</body>
</html>