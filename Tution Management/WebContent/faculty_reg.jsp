<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
  <title> Faculty Registration Form</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <style>
   body {font-family: Arial, Helvetica, sans-serif;
       /*background-image: url("chemistry-bg-4.jpg");
       background-color: white;*/ }
       
  </style>
</head>

<body>

<%!
	Statement s;
	ResultSet course_details;
	String course_name, course_full_name;
	int course_id, class_name;
	String[] courses_selected;	
	ResultSet i_subjects;
	String subject_qualified;
	int faculty_id;
	

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

try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    s=con.createStatement();
	ResultSet temp = s.executeQuery("SELECT * FROM faculty ORDER BY faculty_id DESC LIMIT 1;");
	if(!temp.next()) {
		faculty_id = 20001;
	}
	else
		faculty_id = temp.getInt("faculty_id")+1;
	course_details = s.executeQuery("SELECT * FROM course;");

}catch(SQLException e) {
	System.out.println(e.getErrorCode());
}	
%>

<div class="container" style="margin-top: 5%">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>Faculty Register</strong>
                 </div>
  <div class="panel-body">
  <form class="form-horizontal" method="POST" action="faculty_reg_process.jsp" >
      
      <div class="form-group">
      <label class="control-label col-sm-2" for="email">AUTO-GENERATED FACULTY ID:</label>
      <div class="col-sm-10">          
        <input type="number" class="form-control" id="faculty_id"  name="faculty_id" value="<%=faculty_id %>" readonly>
      </div>
      </div>
       
    <div class="form-group">  
      <label class="control-label col-sm-2" for="first_name">FIRST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control"pattern="[A-Za-z]{4,}"
        title="Only letters allowed no whitespaces." id="first_name" placeholder="Enter name" name="first_name">
      </div>
       <label class="control-label col-sm-2" for="last_name">LAST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control" id="last_name"pattern="[A-Za-z]{4,}"
        title="Only letters allowed no whitespaces." placeholder="Enter name" name="last_name">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="address">ADDRESS:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="address" placeholder="Enter adddress" name="address">
      </div>
    </div>
    <label class="control-label col-sm-2" for="gender">GENDER:</label>
	<label class="radio-inline"><input type="radio" name="gender" value="Male" >Male</label>
	<label class="radio-inline"><input type="radio" name="gender" value="Female">Female</label><br><br>

    <div class="form-group">
      <label class="control-label col-sm-2" for="DOB">DOB:</label>
      <div class="col-sm-10">          
        <input type="date" class="form-control" id="DOB" placeholder="Enter dob" name="DOB">
      </div>
     </div>
     <div class="form-group">
      <label class="control-label col-sm-2" for="email">EMAIL:</label>
      <div class="col-sm-10">          
        <input type="email" class="form-control" id="" placeholder="Enter email" name="email">
      </div>
      </div>
      <div class="form-group">
      <label class="control-label col-sm-2" for="phone">MOBILE NO:</label>
      <div class="col-sm-10">          
        <input type="tel" class="form-control" id="phone"pattern="[1-9]{1}[0-9]{9}"
        title="Enter 10 digit mobile number" placeholder="Enter mobile no" name="phone">
      </div>
      </div>
       
      <div class="form-group">
      <label class="control-label col-sm-2" for="qualifications">QUALIFICATIONS:</label>
      <div class="col-sm-10"> 
         <select name="qualifications" id="qualifications"  size="2" multiple>  
         <option> B. Ed </option>
         <option> M. Ed </option>
         </select>
      	</div>
    	</div>
    	
     <div class="form-group">
      <label class="control-label col-sm-2" for="course">COURSE:</label>
      <div class="col-sm-10"> 
       <select name="course" id="course" class="course" style="width: 300px;" onchange="course_change()" multiple>  
<%while(course_details.next()) { 
	course_name = course_details.getString("course_name");
	class_name = course_details.getInt("class");
	course_id = course_details.getInt("course_id");
	course_full_name = class_name + " " + course_name;
%>          
       <option value="<%=course_id%>"><%=course_full_name%></option>
<% }%>
       </select>
      </div>
     </div>  
     
     <div class="form-group">
      <label class="control-label col-sm-2" for="subjects_taught">SUBJECTS TAUGHT:</label>
      <div class="col-sm-10"> 
       <select name="subjects_taught" class="subjects_taught" style="width: 300px" size=14 multiple>  
       </select>
      </div>
     </div>
     
     
     
     <div class="form-group">
      <label class="control-label col-sm-2" for="batch">BATCH:</label>
      <div class="col-sm-10"> 
       <select name="batch" class="batch" multiple>  
       <%
       		ResultSet batch_details = s.executeQuery("SELECT DISTINCT batch_name FROM batch;");
       	while(batch_details.next()) {
       %>
       <option> <%=batch_details.getString("batch_name") %></option>
       <% }%>
       </select>
      </div>
     </div>             	
              
  
     <div class="form-group">
      <label class="control-label col-sm-2" for="years">Years Of Experience:</label>
      <div class="col-sm-10">          
      <input type="number" min="1" max="30" step="1" name="years" />
      </div>
    </div>
  
  
     <div class="form-group">
      <label class="control-label col-sm-2" for="salary">MONTHLY SALARY:</label>
      <div class="col-sm-10">          
      <input type="number" min="5000" max="30000" step="100" name="salary" />
      </div>
    </div>

  <div class="form-group">
      <label class="control-label col-sm-2" for="username">USERNAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="username" name="username" value="<%=faculty_id %>" readonly>
      </div>
    </div>
      <div class="form-group">
      <label class="control-label col-sm-2" for="password">Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="passowrd" placeholder="Enter password" name="pass">
      </div>
    </div>
    
      <div class="form-group">
      <label class="control-label col-sm-2" for="repassword">Confirm Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="repassword" placeholder="Re-enter password" name="repass">
      </div>
    </div>
    
    <input id="all_array" hidden />
    

    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-default" value="submit" >SUBMIT</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
        <button type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>
    </div>

  </form>
</div>
</div>
</div>
</div>

<script>
function course_change() {
	var array = [];	
		for (var i=0; i < document.getElementById("course").options.length; i++) {
			
			if(document.getElementById("course").options[i].selected) {	

				array.push(document.getElementById("course").options[i].value);
			}
		}	
		
		var courses_selected =  array.join("::");		
		
		$.ajax ({
			type: "POST",
			url: "forward_faculty_subject.jsp",
			data: {courses_selected: courses_selected},
			cache: false,
			success: function(response)
	        {
	            $(".subjects_taught").html(response);
	        }			
		});
}

function validate(){
	  var password = document.getElementById("password")
	  , confirm_password = document.getElementById("repassword");
	  
	  
	  if(document.getElementById("password").value != document.getElementById("repassword").value) {
    	confirm_password.setCustomValidity("Passwords Don't Match"+" "+password.value+" "+repassword.value);
    	return false;
  } else {
    	confirm_password.setCustomValidity('');
    return true;
  }
}

</script>

</body>
</html>

