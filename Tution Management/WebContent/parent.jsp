<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<% Class.forName("com.mysql.jdbc.Driver");  %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>parent profile</title>
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

body {background-color: #DCDCDC;}

 </style>
</head>
<body>
       
      <%!
       
       String roll_no;
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
            
            ResultSet  resultset= statement.executeQuery("select * from parent  where p_id = ' " +uname +" ' ");
   if( resultset.next())
   {
%>


<div class="container" >


  <div  class="col-md-offset-2" class="row col-md-8">
  
  <div  style = "background-color: white">       
  <table class="table table-bordered"  style="border:2px solid black;  margin:5% 0px 0px 0px;" id="someid">
    
      <tr> <td><h4> Personal Details</h4></td><td></td></tr>
   
    <tbody>
      <tr>
        <td>ID</td>
        <td><%= resultset.getString("p_id") %></td>
      
      </tr>
      <tr>
        <td>Name</td>

        <td><%= resultset.getString("p_name") %></td>
      
      </tr>
      <tr>
        <td>Mobile No</td>
        <td><%= resultset.getString("email") %></td>
        
      </tr>
        <tr>
        <td>Email</td>
        <td><%= resultset.getString("mobile") %></td>
       </tr>
       
<%
   }
%>







  <tr> <td><h4>Student Details</h4></td><td></td></tr>
   
   
<%

ResultSet  rs= statement.executeQuery("select roll_no ,first_name ,last_name,course_name,class,batch_name from student  natural join course natural join  batch  where parent_id = ' " +uname +" ' ");


if( rs.next())
{

	 roll_no = rs.getString("roll_no");
%>
   
   
       <tr>
        <td>Student Id</td>
        <td><%= rs.getString("roll_no") %></td>
        
      </tr>
           
           <tr>
        <td>Name</td>
        <td><%= rs.getString("first_name") %>   <%= rs.getString("last_name") %></td>
        
      </tr>

        <tr>
        <td>Course</td>
        <td><%= rs.getString("course_name") %></td>
        
      </tr>

          <tr>
        <td>Class</td>
        <td><%= rs.getString("class") %></td>
        
      </tr>

        <tr>
        <td>Batch</td>
        <td><%= rs.getString("batch_name") %></td>
        
      </tr>
      
  <%
}  
 

ResultSet  rs2= statement.executeQuery("select * from student_subject natural join subject where student_roll_no  = ' " + roll_no +" ' ");


if( rs2.next())
{
do{
%>
     <tr>
	<td>Subject</td>
	<td><%= rs2.getString("subject_name") %></td>
   </tr>
<%  }while(rs2.next()); 
  }%>       
  

      
  
    
  
 
  <tbody>
  </table>
  
 
</div>
</div>
</div>

</body>
</html>