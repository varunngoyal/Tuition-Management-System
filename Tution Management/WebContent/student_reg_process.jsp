<%@page import="java.sql.*"%>
<%@page import="com.varun.jspex.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
  <title>Registration Form</title>
  <style>
   body {font-family: Arial, Helvetica, sans-serif;
       /*background-image: url("bg5.jpg");*/}
   
  </style>
  <meta charset="utf-8">
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

	Student_info obj = new Student_info();  
	obj.setFirst_name(request.getParameter("first_name"));
	obj.setLast_name(request.getParameter("last_name"));
	obj.setAddress(request.getParameter("address"));
	obj.setCollege(request.getParameter("college"));
	obj.setRoll_no(request.getParameter("roll_no"));
	obj.setDob(request.getParameter("dob"));
	obj.setPhone(request.getParameter("phone"));
	obj.setEmail(request.getParameter("email"));
	obj.setGender(request.getParameter("gender"));
	//obj.setPic(request.getParameter("pic"));
	obj.setPass(request.getParameter("pass"));
	obj.setPid(request.getParameter("pid"));
	obj.setPname(request.getParameter("pname"));
	obj.setPemail(request.getParameter("pemail"));
	obj.setPphone(request.getParameter("pphone"));
	
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    
   	Statement s=con.createStatement();
   	s.executeUpdate(obj.insertParentLoginPartial());
   	s.executeUpdate(obj.insertParent());
  	s.executeUpdate(obj.insertStudentLogin());
   	s.executeUpdate("INSERT INTO student"+
   	    	"(roll_no, first_name, last_name, email, phone, DOB, gender, address, college_name, parent_id) VALUES ("+
   	    			request.getParameter("roll_no")+",'"+
   	    			request.getParameter("first_name")+"','"+
   	    			request.getParameter("last_name")+"','"+
   	    			request.getParameter("email")+"', "+
   	    			request.getParameter("phone")+",'"+request.getParameter("dob")+"','"+
   	    			request.getParameter("gender")+"','"+
   	    			request.getParameter("address")+"','"+
   	    			request.getParameter("college")+"',"+
   	    			request.getParameter("pid")+ " ); ");
	con.close();   	
%>
<div class="container" style="margin-top: 5%">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Parent Password</strong>
                 </div>
 <div class="panel-body">
  <form class="form-horizontal" action="student_reg_fees.jsp" method="Post" onsubmit = "return validate()">
    <div class="form-group">
      <label class="control-label col-sm-2" for="user name">USERNAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="username" name="username" value="<%=obj.getPid()%>" readonly>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="password">Parent's Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="password" placeholder="Enter password" name="parent_pass">
      </div>  
    </div>
      <div class="form-group">
      <label class="control-label col-sm-2" for="password">Confirm Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="repassword" placeholder="Enter password" name="parent_repass">
      </div>
    </div>    

    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-default" value="next">NEXT</button>
      </div>
    </div>
</form>
</div>
</div>
</div>
</div>
<script>
  function validate(){
	  var password = document.getElementById("parent_pass")
	  , confirm_password = document.getElementById("parent_repass");
	  
	  if(password.value != repassword.value) {
      	confirm_password.setCustomValidity("Passwords Don't Match"+" "+parent_pass.value+" "+parent_repass.value);
      	return false;
    } else {
      	confirm_password.setCustomValidity('');
      return true;
    }
  }
  </script>
</body>
</html>













