<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
	
<% Class.forName("com.mysql.jdbc.Driver");  %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Student Profile</title>
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

 <%@page import="java.util.Base64"%>
 <%!
 String url,uname, pass;
 Properties prop = new Properties();
 InputStream input = null;
 Connection con=null;
 %>
   
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
  <h2><center>Student Profile<center></h2>   
  <div  style = "background-color: white">       
  <table class="table table-bordered"  style="border:2px solid black" id="someid">
  
   <%

ResultSet  rs2= statement.executeQuery("select * from student_image  where roll_no = ' " +uname +" ' ");
   if( rs2.next())
 {
	 %>
      <tr id = "idh"> <td><h4> Profile Photo</h4></td>
      <td>  <img  src = "data:image/png;base64,<%=Base64.getEncoder().encodeToString(rs2.getBytes("image")) %>"  style =" width : 200px; height : 200px; border: 2px solid black" >
  <%
  } 
%></td></tr>
      
      <%
      
      ResultSet resultset = statement.executeQuery("select * from student as s, batch as b, course as c , parent as p  where s.parent_id = p.p_id  and c.course_id = b.course_id and  c.course_id = s.course_id and b.batch_id = s.batch_id and  roll_no = '" + uname + "'") ; 
      
            if(!resultset.next()  ) {
            out.println("Sorry, could not find that users. ");
        
        
         } else {  
      
      %>
      <tr> <td><h4> Personal Detail</h4></td><td></td></tr>
   
    <tbody>
      <tr>
        <td>Roll No</td>
        <td><%= resultset.getString("roll_no") %></td>
      
      </tr>
      <tr>
        <td>Name</td>
        <td><%= resultset.getString("first_name") %>    <%= resultset.getString("last_name") %></td>
      
      </tr>
      <tr>
        <td>Date of Birth</td>
        <td><%= resultset.getString("DOB") %></td>
        
      </tr>
        <tr>
        <td>Gender</td>
        <td><%= resultset.getString("gender") %></td>
        
      </tr>
      </tr>
        <tr>
        <td>Address</td>
        <td><%= resultset.getString("address") %></td>
        

      </tr>
       </tr>
       
        <tr>
        <td>Mobile No</td>
        <td><%= resultset.getString("phone") %></td>
      </tr>

       </tr>
        <tr>
        <td>Email</td>
        <td><%= resultset.getString("s.email") %></td>
        
      </tr>

            
      <tr> <td><h4>Educational Detail</h4></td><td></td></tr>
   
           
             <tr>
        <td>Xth Percentage</td>
        <td><%= resultset.getString("tenth_perc") %> </td>
        
      </tr>
           
           <tr>
        <td>School Name</td>
        <td><%= resultset.getString("school_name") %></td>
        
      </tr>
           <tr>
        <td>College  Name</td>
        <td><%= resultset.getString("college_name") %></td>
        
      </tr>

           
      <tr> <td><h4> Admission Detail</h4></td><td></td></tr>
  
         </tr>
        <tr>
        <td>Admitted Year</td>
        <td><%= resultset.getString("year") %></td>
        
      </tr>
        </tr>
           <tr>
        <td>Course</td>
        <td><%= resultset.getString("course_name") %></td>
        
      </tr>
           <tr>
        <td>class</td>
        <td><%= resultset.getString("class") %></td>
        
      </tr>

       </tr>
           <tr>
        <td>Batch</td>
        <td><%= resultset.getString("batch_name") %></td>
        
      </tr>
      
      
      <%
         }
      
 ResultSet resultset2 = statement.executeQuery("select * from student_subject natural join subject  where student_roll_no = ' " + uname + " ' ");
      
       if(resultset2.next())
       {
    	   do {
       
      %>
      
           <tr>
        <td>Subject</td>
        <td><%= resultset2.getString("subject_name") %></td>
        
      </tr>
      <%
    	   }while(resultset2.next());
       }
      %>
         
         
         
      <tr><td> <h4> Parent Detail</h4></td><td></td></tr>
     
     <%
     ResultSet resultset3 = statement.executeQuery("select * from student as s, batch as b, course as c , parent as p  where s.parent_id = p.p_id  and c.course_id = b.course_id and  c.course_id = s.course_id and b.batch_id = s.batch_id and  roll_no = '" + uname + "'") ; 

     if(resultset3.next())
     {
     %>
   
   
        <tr>
        <td>Parent ID</td>
        <td><%= resultset3.getString("parent_id") %></td>
        
      </tr>
        
           <tr>
        <td>Parent Name</td>
        <td><%= resultset3.getString("p_name") %></td>
        
      </tr>
           <tr>
        <td>Mobile No</td>
        <td><%= resultset3.getString("mobile") %></td>
        
      </tr>

     
           <tr>
        <td>Email</td>
        <td><%= resultset3.getString("p.email") %></td>
        
      </tr>
         
    </tbody>
  </table>
  
  <% 
           } 
       %>
</div>
</div>
</div>

</body>
</html>