<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %> 
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>Administrator - Delete Student</title>
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
		course_details = s.executeQuery("SELECT * FROM course;");

%>

<div class="container" style="margin-top: 5%">
  <div class="col-sm-12">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>DELETE STUDENT : </strong>
                 </div>
 <div class="panel-body">
<form method="post">
        <div class="form-group">
      <label class="control-label col-sm-2" for="search_by">Search By:</label>
      <div class="col-sm-10"> 
 <select name="search_by" id="search_by" class="form-control" onchange="select_input()">
	<option value="first_name">First Name</option>
	<option value="last_name">Last Name</option>
	<option value="roll_no">Roll No.</option>
	<option value="course_id">Course Name</option>
	<option value="batch_name">Batch Name</option>
	<option value="course_and_batch">Course and Batch</option>
</select>
</div>
</div>  <br><br>

<div id="roll_no_group" style="display:none">
<div class="form-group">
<label class="control-label col-sm-2" for="rn"> ROLL NO.:</label>
<div class="col-sm-8"> 
<input name="roll_no" class="form-control" type="number" id="rn" placeholder="Roll No." value="3000" > 
</div>
</div>
</div>

<div id="first_name_group" >
<div class="form-group">
<label class="control-label col-sm-2" for="fn"> FIRST NAME:</label>
<div class="col-sm-8"> 
<input name="fn" id="fn" class="form-control" placeholder="First Name" value="First Name" > 
</div>
</div>
</div>

<div id="last_name_group" style="display:none">
<div class="form-group">
<label class="control-label col-sm-2" for="ln"> LAST NAME:</label>
<div class="col-sm-8"> 
<input name="ln" id="ln" class="form-control" placeholder="Last Name" value="Last Name" > 
</div>
</div>
</div>

<div id="course_div" style="display: none">
<div class="form-group">
<label class="control-label col-sm-2" for="course">COURSE:</label>
<div class="col-sm-10"> 
<select name="course" id="course_id" class="form-control" style="width: 178px;">  
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
</div>
 	 
<div id="batch_div" style="display: none">
<div class="form-group">
<label class="control-label col-sm-2" for="course">BATCH:</label>
<div class="col-sm-10"> 
<select name="batch" class="form-control" id="batch_name" style="width: 178px;" >  
       <%
       	ResultSet batch_details = s.executeQuery("SELECT DISTINCT batch_name FROM batch;");
       	while(batch_details.next()) {
       %>
       <option> <%=batch_details.getString("batch_name") %></option>
       <% }%>
</select>
</div>
</div>
</div>

<br>
	    <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-2">
         <button type="button" class="btn btn-primary btn-md btn-block"
          id="search_btn" onclick="result_table()" style="margin-top: 10%;margin-bottom:10%;">
             <span class="glyphicon glyphicon-search"></span> Search</button>
      </div> 
    </div>
<div id="putter"></div>

</form>

</div>
</div>
</div>
</div>

<%		
}catch(SQLException e) {
	System.out.println(e);
}	
%>

<script>

function result_table() {
	var selected_type = document.getElementById("search_by").value;
	var data1 = data();
	var data2=null;
	if(selected_type == 'course_and_batch') {
		data2 = document.getElementById("batch_name").value;	
	}


	$.ajax ({
		type: "POST",
		url: "student_search_results_for_delete.jsp",
		data: {selected_type: selected_type,
			   data1: data1,
			   data2: data2},
		cache: false,
		success: function(response)
        {
            $("#putter").html(response);

        }
    });
    return false;

}

function select_input() {
	var selected_type = document.getElementById("search_by").value;
	var roll_no = document.getElementById("roll_no_group");
	var first_name = document.getElementById("first_name_group");
	var last_name = document.getElementById("last_name_group");
	var course = document.getElementById("course_div");
	var batch = document.getElementById("batch_div");
	
	
	if(selected_type == "roll_no") {
		roll_no.style.display = "block";
		first_name.style.display = "none";
		last_name.style.display = "none";
		course.style.display = "none";
		batch.style.display = "none";
			
	} else if(selected_type == "first_name") {
		roll_no.style.display = "none";
		first_name.style.display = "block";
		last_name.style.display = "none";
		//course_and_batch.style.display = "none";	
		course.style.display = "none";
		batch.style.display = "none";
		
	} else if(selected_type == "last_name") {
		roll_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "block";
		course.style.display = "none";
		batch.style.display = "none";
		
	} else if(selected_type == "course_id") {
		roll_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		course.style.display = "block";
		batch.style.display = "none";		
		
	} else if(selected_type == "batch_name") {
		roll_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		course.style.display = "none";
		batch.style.display = "block";
	} else {
		roll_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		course.style.display = "block";
		batch.style.display = "block";

	} 
}

function data() {
	var selected_type = document.getElementById("search_by").value;
	var roll_no = document.getElementById("rn");
	var first_name = document.getElementById("fn");
	var last_name = document.getElementById("ln");
	var course = document.getElementById("course_id");
	var batch = document.getElementById("batch_name");
	var data;
	
	
	if(selected_type == "roll_no") {
		data = roll_no.value;
			
	} else if(selected_type == "first_name") {
		data = first_name.value;
		
	} else if(selected_type == "last_name") {
		data = last_name.value;

		
	} else if(selected_type == "course_id") {
		data = course.value;
		
		
	} else if(selected_type == "batch_name") {
		data = batch.value;

	} else {
		data = course.value;
		
	} 	
	return data;
}
</script>

</body>
</html>	

