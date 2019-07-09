<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>	

<% Class.forName("com.mysql.jdbc.Driver");  %>
<%@page import="java.util.Base64"%>
<!DOCTYPE html>
<html>
<head>
 <title>FACULTY PROFILE</title>
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

 <style>
   body {font-family: Arial, Helvetica, sans-serif;
          background-color : #CC9900;}

   .container{
    margin:20px 100px 20px 100px;
}

   .border {
     border-style: solid;
    border- width: 1px;
    border-color: black;
    font-size : 15px;
    color: black;
    padding : 0px 0px 0px 10px;
}

  .col-container {
    display: table;
    width: 100%;
    border-style: solid;
    border- width: thin;
    border-color: #D8D8D8;
    
}
.col {
    display: table-cell;
}

.myDIV {
    text-align: justify;
    text-align-last:left;
    
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
        <%  
        Blob image = null;
       try {
        
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
        
   
    <div class="container">
  <div class=" col-md-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                <strong><center>FACULTY PROFILE</center></strong>
                </div>
  
  <div class="panel-body">
        <div>
       <hr>
       <h4><center><b>Profile Photo</b></center></h4>
       <hr>
       <div style = "height:200px">
         <%

ResultSet  rs5= statement.executeQuery("select * from faculty_image  where faculty_id = ' " +uname +" ' ");
   if( rs5.next())
 {
	 %>
     
  <img  src = "data:image/png;base64,<%=Base64.getEncoder().encodeToString(rs5.getBytes("faculty_image")) %>"  style =" width : 200px; height : 200px; border: 2px solid black" >
  <%
  } 
%>
       
       </div>
       <br>
       <div>
     <%  ResultSet resultset = statement.executeQuery("select * from faculty where  faculty_id = '" + uname + "'") ;  
       if(!resultset.next()) {
           out.println("Sorry, could not find that users. ");

       }           
    %>
       <hr>
       <h4><center><b>Personal Detail</b></center></h4>
       <hr>
       </div>
       <br>
       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv"> Faculty Id</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("faculty_id") %></div>
      </div>
      </div>    
       <br>
       <br><br>

        
       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Name</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("first_name") %>   <%= resultset.getString("last_name") %> </div>
      </div>
      </div>    
    
       <br><br><br>
      
       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Gender</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("gender") %></div>
      </div>
      </div>    
    
       <br><br><br>

      
       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">DOB</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("dob") %></div>
      </div>
      </div>    
    
       <br><br><br>


       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Mobile No.</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("mobile_no") %></div>
      </div>
      </div>    
    
       <br><br><br>

       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Address</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset.getString("address") %></div>
      </div>
      </div>    

     
    <br>
       <br>
        
         <br>
         <div ><hr>
        <h3><center><b>Professional Detail</b></center></h3>
         <hr>
         </div>
         <br>



<%
ResultSet resultset1 = statement.executeQuery("select * from faculty_qualification  where  faculty_id = '" + uname + "'") ;  
if(!resultset1.next()) {
    out.println("Sorry, could not find that users. ");

}

%>   
       
       <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Qualification</div></label>
      <div class="col-sm-10">          
      <div  class = "border"><%= resultset1.getString("qualification") %></div>  
      </div>
      </div>    
       <br>
       <br><br>

<%
ResultSet resultset2 = statement.executeQuery("select * from faculty  where  faculty_id = '" + uname + "'") ;  
if(!resultset2.next()) {
	    out.println("Sorry, could not find that users. ");
}
%>
          <div class="col-sm-12">
      <label class="control-label col-sm-2"><div class = "myDiv">Year of Experience</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset2.getString("years_of_exp") %></div>
      </div>
      </div>    
       <br>
       <br>
       
  <%
  
  ResultSet rs2 = statement.executeQuery("select * from faculty_batch natural join batch natural join course  where  faculty_id = '" + uname + "'") ;  
  if(!rs2.next()) {
	   out.println("Sorry, could not find that users. ");
  }
  do{
  
  %>
       
      <div class="col-sm-12">
      <label class="control-label col-sm-2" ><div class = "myDiv"> class</div></label>
      <div class="col-sm-2">          
             <div  class = "border"><%= rs2.getString("class") %></div>
      </div>
     
       
      <label class="control-label col-sm-2" ><div class = "myDiv"> course</div></label>
      <div class="col-sm-2">          
             <div  class = "border"><%= rs2.getString("course_name") %></div>
      </div>
     
      <label class="control-label col-sm-2" ><div class = "myDiv"> Batch</div></label>
      <div class="col-sm-2">          
             <div  class = "border"><%= rs2.getString("batch_name") %></div>
      </div>
      </div>    
       <br>
       <br>
       <br>
 <%}while(rs2.next()); %>     
<%
ResultSet rs = statement.executeQuery("select * from faculty_subject natural join subject where  faculty_id = '" + uname + "'");  
if(!rs.next()) {
    out.println("Sorry, could not find that users. ");

}
do{
%>
      <div class="col-sm-12">
      <label class="control-label col-sm-2" ><div class = "myDiv">Subject</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= rs.getString("subject_name") %></div>
      </div>
      </div>    
       <br><br><br>
<%}while(rs.next()); %>       
       
<%
ResultSet resultset3 = statement.executeQuery("select * from faculty  where  faculty_id = '" + uname + "'") ;  
if(!resultset3.next()) {
	   //error code
}
%>
          <div class="col-sm-12">
      <label class="control-label col-sm-2" ><div class = "myDiv"> Salary</div></label>
      <div class="col-sm-10">          
             <div  class = "border"><%= resultset3.getString("salary") %></div>
      </div>
      </div>    
       <br>
       <br>
</div>

</body>
</html>
        

  <% 
       }catch(SQLException e) {
    	   out.println(e);
       }
       %>
       

     
</body>
</html>