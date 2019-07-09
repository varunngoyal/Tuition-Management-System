<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Registration Form</title>
  <style>
   body {font-family: Arial, Helvetica, sans-serif;
       background-color: white;}
   
  </style>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<div class="container" style="margin-top: 5%">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Student Register</strong>
                 </div>
<%!
Connection con=null;
int roll_no=0;
int pid=0;
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
%>
  	
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

try {
	Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);

	Statement s=con.createStatement();
    String query="SELECT * FROM student order by roll_no DESC limit 1;";
    ResultSet rs = s.executeQuery(query);
    if(!rs.next()) {
    	roll_no = 1;
    }
    else {
    	roll_no = rs.getInt("roll_no")+1;
    }
}
finally {
    try {con.close();}catch(Exception e) {}
} 
session.setAttribute("roll_no", roll_no);

%>

  <div class="panel-body">
  <form class="form-horizontal" method="post" action="student_reg_process.jsp" onsubmit = "return validate()">
    <div class="form-group">
      <label class="control-label col-sm-2" for="roll_no"> ROLL NUMBER:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="roll_no" value="<%=roll_no%>"  name="roll_no" readonly>
      </div>
    </div>

    <div class="form-group">
      <label class="control-label col-sm-2" for="first_name">FIRST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control" id="first_name" pattern="[A-Za-z]{4,}"
        title="Only letters allowed no whitespaces." placeholder="Enter name" name="first_name" required>
      </div>
       <label class="control-label col-sm-2" for="last_name">LAST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control" id="last_name" pattern="[A-Za-z]{4,}"
        title="Only letters allowed no whitespaces." placeholder="Enter name" name="last_name" required>
      </div>
    </div>
      
    <div class="form-group">
      <label class="control-label col-sm-2" for="address">ADDRESS:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="address" placeholder="Enter adddress" name="address" required>
      </div>
    </div>

     <div class="form-group">
      <label class="control-label col-sm-2" for="college">COLLEGE NAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="college" placeholder="Enter college" name="college" required>
      </div>
    </div>

     <div class="form-group">
      <label class="control-label col-sm-2" for="dob">DOB:</label>
      <div class="col-sm-10">          
        <input type="date" class="form-control" id="dob" placeholder="Enter dob" name="dob" required>
      </div>
     </div>
     
    	<div class="form-group">
      <label class="control-label col-sm-2" for="batch">GENDER:</label>
      <div class="col-sm-10"> 
       <select name="gender">         
       <option value="Male">Male</option>
        <option value="Female">Female</option>
       </select>
      </div>
     </div>     
     
     <div class="form-group">
      <label class="control-label col-sm-2" for="email">STUDENT EMAIL:</label>
      <div class="col-sm-10">          
        <input type="email" class="form-control" id="" placeholder="Enter email" name="email" required>
      </div>
      </div>

      <div class="form-group">
      <label class="control-label col-sm-2" for="phone">MOBILE NO:</label>
      <div class="col-sm-10">          
        <input type="tel" class="form-control" pattern="[1-9]{1}[0-9]{9}"
        title="Enter 10 digit mobile number" id="phone" placeholder="Enter mobile no" name="phone" required>
      </div>
       </div>

<%

try { 
	Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
	Statement s=con.createStatement();
    String query="SELECT p_id FROM parent order by p_id desc limit 1;";
    ResultSet rs = s.executeQuery(query);
    if(!rs.next()) {
    	pid = 5001;
    }
    else {
    	pid = rs.getInt("p_id")+1;
    }
    
}
finally {
    try {con.close();}catch(Exception e) {}
}    	
%>
	<br> 	
    <div class="form-group">
      <label class="control-label col-sm-2" for="pid">AUTO-GENERATED PARENT-ID:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="pid" value="<%=pid%>"  name="pid" readonly>
      </div>
    </div>
  	<br>

       <div class="form-group">
      <label class="control-label col-sm-2" for="pname">PARENT'S NAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="" placeholder="Enter name" pattern="[A-Za-z]{4,}[ ]{1}[A-Za-z]{4,}"
        title="First name and last name seperated by whitespace." name="pname" required>
      </div>
       </div>

     <div class="form-group">
      <label class="control-label col-sm-2" for="pemail">PARENT'S EMAIL:</label>
      <div class="col-sm-10">          
        <input type="email" class="form-control" id="" placeholder="Enter email" name="pemail" required>
      </div>
      </div>

      <div class="form-group">
      <label class="control-label col-sm-2" for="phone">PARENT'S MOBILE NO:</label>
      <div class="col-sm-10">          
        <input type="tel" class="form-control" id="phone" placeholder="Enter mobile no" name="pphone" required>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="user name">USERNAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="username" name="username" value="<%=roll_no%>" readonly>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="password">Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="password" placeholder="Enter password" name="pass" required>
      </div>  
    </div>
    
      <div class="form-group">
      <label class="control-label col-sm-2" for="password">Confirm Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="repassword" placeholder="Enter password" name="repass" required>
      </div>
    </div>    

    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-default" value="next" onclick="validate()">NEXT</button>
      </div>
    </div>

  </form>
  <script>


  function validate(){
	  var password = document.getElementById("password")
	  , confirm_password = document.getElementById("repassword");
	  
	  if(password.value != repassword.value) {
      	confirm_password.setCustomValidity("Passwords Don't Match");
      	return false;
    } else {
      	confirm_password.setCustomValidity('');
      return true;
    }
  }

  </script>
</div>
</div>
</div>
</div>

</body>
</html>
