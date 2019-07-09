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
</head>

<body>
<%!
String url,uname, pass;
int class_name;
String batch_name ,course_name;
int total_fees ,fees_due,amount_paid;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
int fees_paid;
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
   
   String batch_id = request.getParameter("id");
   
   
   ResultSet rs = statement.executeQuery("select * from batch natural join course where batch_id = ' " + batch_id + "' ");
   
   if(rs.next())
   {
	   class_name = rs.getInt("class");
	   course_name = rs.getString("course_name");
	   batch_name = rs.getString("batch_name");

   }
ResultSet resultset = statement.executeQuery("select student_id,total_fees,fees_due,date_of_payment,payment_mode,first_name,last_name from fees  natural join student where batch_id = ' " + batch_id + " ' and student_id = roll_no;") ; 
   
  if(!resultset.next()  ) {
	  {%>
		<script>
		swal("No Record found!");
		</script>
	<%} 
  
  
   } else {  
	   
	    total_fees = resultset.getInt("total_fees");
	    fees_due =   resultset.getInt("fees_due");
	    amount_paid= total_fees - fees_due;
			   
%>	         

         <h4><center>Fees Report of <%=class_name %>th  <%=course_name %> for <%=batch_name %> batch</center></h4>
     
                  <br>
             
       
      <table class="table table-bordered table-striped" style= "margin: 30px 20px 0px 20px;">
		<tr>
			<th>Roll No</th><th>Name</th><th>Total Fees</th>
			<th>Amount paid</th><th>date of last payment </th><th>Fees Due </th>
		</tr>

   <% do {
      
 %>
		<tr>
			<td><%= resultset.getString("student_id") %>
			 </td>
		   <td><%= resultset.getString("first_name") %>  <%= resultset.getString("last_name") %></td>
		   <td><%= resultset.getString("total_fees") %>
			 </td>
			 <td><%=amount_paid%></td>
			 <td><%= resultset.getString("date_of_payment") %></td>
			 <td><%= resultset.getString("fees_due") %></td>
	 </tr>
		   
		 
<% }while(resultset.next());  %>		
		</table>
   



 <%
   }
 %> 
 
 



</body>
</html>