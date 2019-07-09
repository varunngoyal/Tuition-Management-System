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
<title>student profile</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

 <style>
   body {font-family: Arial, Helvetica, sans-serif;}

 .container{
    margin:20px 100px 20px 100px;
}

   .border {
    border-style: solid;
    border-width: 5%;
    padding : 0px 10px 0px 10px;
   
}
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

 ResultSet resultset = statement.executeQuery("select * from student as s, batch as b, course as c , parent as p  where s.parent_id = p.p_id  and c.course_id = b.course_id and  c.course_id = s.course_id and b.batch_id = s.batch_id and  roll_no = '" + uname + "'") ; 
            
        // statement.executeQuery("select roll_no , s.parent_id,first_name ,date_of_payment,last_name,s.email,phone,DOB,gender,tenth_perc ,school_name , address ,college_name ,p_name,p.email,mobile from fees as f,student as s,parent as p where s.parent_id = p.p_id and s.roll_no = f.student_id and roll_no = ' " + uname + " '");

        
    //   ResultSet rs = statement1.executeQuery("select * from student as s ,parent as p where  s.parent_id = p.p_id and  roll_no = '" + username + "'") ; 
         
            if(!resultset.next()  ) {
              out.println("Sorry, could not find that users. ");
          
          
           } else {  
        
           
        %>
        
   
  <div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong><center>STUDENT PROFILE</center></strong>
                 </div>
  
  <div class="panel-body">
        <hr><h6><center>Personal Detail</center></h6><hr>
       <div class="col-sm-8">
      <label class="control-label col-sm-2"> RollNo:</label>
      <div class="col-sm-6">          
             <div  class = "border"><%= resultset.getString("roll_no") %></div>
      </div>
      </div>    
       <br>
       <br>

         <div class="col-sm-8">
      <label class="control-label col-sm-2" > Admission year:</label>
      <div class="col-sm-6">          
             <div  class = "border"><%= resultset.getString("year") %></div>
      </div>
      </div>    
       <br>
       <br>

       <div class="col-sm-8">
      <label class="control-label col-sm-2">Admitted batch:</label>
      <div class="col-sm-6">          
             <div  class = "border"><%= resultset.getString("batch_name") %></div>
      </div>
      </div>  
      </div>  
       <br>
       <br>
       <div>
       <label class="control-label col-sm-2">First Name:</label>  
      <div class="col-sm-4">
                   <div  class = "border"><%= resultset.getString("first_name") %></div>
      </div>
        <label class="control-label col-sm-2">Last Name:</label>
      <div class="col-sm-4">
                 <div  class = "border"><%= resultset.getString("last_name") %></div>
      </div>
    </div>

      <br>
       <br>
       <div>
       <label class="control-label col-sm-2">Gender:</label>  
      <div class="col-sm-4">
                   <div  class = "border"><%= resultset.getString("gender") %></div>
      </div>
        <label class="control-label col-sm-2">DOB:</label>
      <div class="col-sm-4">
                 <div  class = "border"><%= resultset.getString("DOB") %></div>
      </div>
    </div>
      <br>
       <br>

       <div class="col-sm-12">
      <label class="control-label col-sm-2">Address:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("address") %></div>
      </div>
      </div>    

     
    <br>
       <br>

       <div class="col-sm-12">
      <label class="control-label col-sm-2">phone no:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("phone") %></div>
      </div>
      </div>    
    
       <br><br>
       <div class="col-sm-12">
      <label class="control-label col-sm-2">Email:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("s.email") %></div>
      </div>
      </div>    
       <br>
       <br>
      
        
         <br>
        <hr><h6><center>Course Detail</center></h6><hr>

          <div class="col-sm-12">
      <label class="control-label col-sm-2"> Course Name:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("course_name") %></div>
      </div>
      </div>    
       <br>
       <br>
       
          <div class="col-sm-12">
      <label class="control-label col-sm-2" > Class :</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("class") %></div>
      </div>
      </div>    
       <br>
       <br>

         <div class="col-sm-12">
      <label class="control-label col-sm-2" > College Name:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("college_name") %></div>
      </div>
      </div>    
       <br>
       <br>

         <div>
       <label class="control-label col-sm-2">School Name:</label>  
      <div class="col-sm-4">
                   <div  class = "border"><%= resultset.getString("school_name") %></div>
      </div>
        <label class="control-label col-sm-2">XTH Percentage:</label>
      <div class="col-sm-4">
                 <div  class = "border"><%= resultset.getString("tenth_perc") %></div>
      </div>
    </div>

         <br><br>
        <br>
        <hr><h6><center>Parent Information</center></h6><hr>

          <div class="col-sm-12">
      <label class="control-label col-sm-2"> parent_id:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("parent_id") %></div>
      </div>
      </div>    
       <br>
       <br>

         <div class="col-sm-12">
      <label class="control-label col-sm-2" > parent Name:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("p_name") %></div>
      </div>
      </div>    
       <br>
       <br>

       <div class="col-sm-12">
      <label class="control-label col-sm-2">Email:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("p.email") %></div>
      </div>
      </div>    
       <br>
       <br>

     <div class="col-sm-12">
      <label class="control-label col-sm-2">Mobile No:</label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("mobile") %></div>
      </div>
      </div>    
       <br>
       <br>

   
           

  <% 
           } 
       %>
   
  <%

ResultSet  rs2= statement.executeQuery("select * from student_image  where roll_no = ' " +uname +" ' ");
%>       



 <% if( rs2.next())
 {
	 %>
	  <table border=2>
     <tr><th>DISPLAYING IMAGE</th></tr>
     <tr><td>Image 2</td></tr>
     <tr>
       <td>
 
 <img  src = "data:image/png;base64,<%=Base64.getEncoder().encodeToString(rs2.getBytes("image")) %>"  style =" width : 300px; height : 300px">
  <%
  } 
%>
       </td>
     </tr>
    </table>

 </body>
 </html>




</div>
  

       
<form action ="Logout">

 <button type="submit">Logout</button>
</form>
     
</body>
</html>