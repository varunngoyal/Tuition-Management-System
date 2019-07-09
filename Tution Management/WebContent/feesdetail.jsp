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
             String roll;
             int paid_amount;
             int total;
             int remaining;
             
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
            
            ResultSet  resultset= statement.executeQuery("select roll_no from student where parent_id = ' " +uname +" ' ");
            
            
   if( resultset.next())
   {
        roll = resultset.getString("roll_no");
    //   out.println(roll); 
   }
%>


<div class="container" >


  <div  class="col-md-offset-2" class="row col-md-8">
  
  <div  style = "background-color: white">       
  <table class="table table-bordered"  style="border:2px solid black; margin: 10% 0px 0px 0px;" id="someid">
  
    <% 
    
    
     ResultSet  rs= statement.executeQuery("select * from student  where roll_no = ' " +  roll +" ' ");
            
            
   if( rs.next())
   {
  
%>
  
  <tr> <td><h4> Fees Details</h4></td><td></td></tr>
   
    <tbody>
      <tr>
        <td>Student Name</td>
        <td><%= rs.getString("first_name") %>    <%= rs.getString("last_name") %></td>
      
      </tr>
  
  <% 
   }
     ResultSet  rs2= statement.executeQuery("select * from fees  where student_id = ' " +  roll +" ' ");
            
            
   if( rs2.next())
   {
	      total = rs2.getInt("total_fees");
	      remaining = rs2.getInt("fees_due");
	      
	      paid_amount = total - remaining;
      
%>
    
 
   
    <tbody>
      <tr>
        <td>Student ID</td>
        <td><%= rs2.getString("student_id") %></td>
      
      </tr>
      <tr>
        <td>Total Fees</td>
        <td><%= rs2.getString("total_fees") %></td>
      
      </tr>
      
        <tr>
        <td>Paid Amount</td>
        <td><%= paid_amount %></td>
        
      </tr>
      <tr>
        <td>Date Of Last Payment</td>
        <td><%= rs2.getString("date_of_payment") %></td>
        
      </tr>
        <tr>
        <td>Payment Mode</td>
        <td><%= rs2.getString("payment_mode") %></td>
       </tr>
       
          
      
        <tr>
        <td>Remaining Amount</td>
        <td><%= rs2.getString("fees_due") %></td>
       </tr>
       
<%
   }
%>



  <tbody>
  </table>
  
 
</div>
</div>
</div>

</body>
</html>