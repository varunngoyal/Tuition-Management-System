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
  <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
 integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<title>Administrator - Search Faculty</title>
</head>
<body>

<%!
	Statement s;
	ResultSet subject_details;
	int class_name;
	String course_name;
	
	int faculty_id,subject_id;
	String subject_name, subject_full_name;
	
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

Connection con=null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    s=con.createStatement();
		subject_details = s.executeQuery("SELECT * FROM subject natural join course;");

%>
<div class="container" style="margin-top: 5%">
  <div class="col-sm-12">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>DELETE FACULTY : </strong>
                 </div>
 <div class="panel-body">
<form method="post">
        <div class="form-group">
      <label class="control-label col-sm-2" for="search_by">Search By:</label>
      <div class="col-sm-10"> 
     <select name="search_by" id="search_by" class="form-control" onchange="select_input()">
	<option value="first_name">First Name</option>
	<option value="last_name">Last Name</option>
	<option value="faculty_id">Faculty ID</option>
	<option value="subject_id">Subject Name</option>
	<option value="batch_name">Batch Name</option>
	<option value="subject_and_batch">Subject and Batch</option>
</select>
</div>
</div>
<br><br>

<div id="faculty_id_group" style="display:none">
<div class="form-group">
<label class="control-label col-sm-2" for="fac_id"> FACLUTY ID:</label>
<div class="col-sm-8"> 
<input name="fac_id" type="number" class="form-control" id="fac_id" placeholder="Faculty ID" value="20000" required> 
</div>
</div>
</div>

<div id="first_name_group">
<div class="form-group">
<label class="control-label col-sm-2" for="fn"> FIRST NAME:</label>
<div class="col-sm-8"> 
<input name="fn" id="fn" placeholder="First Name" class="form-control" value="First Name" required>
</div>
</div>
</div>

 

<div id="last_name_group" style="display:none">
<div class="form-group">
<label class="control-label col-sm-2" for="ln"> LAST NAME:</label>
<div class="col-sm-8"> 
<input name="ln" id="ln" placeholder="Last Name" class="form-control" value="Last Name" required> 
</div>
</div>
</div>

<div id="subject_div" style="display: none">
<div class="form-group">
<label class="control-label col-sm-2" for="subject">SUBJECT:</label>
<div class="col-sm-10"> 
<select name="subject" id="subject_id" class="form-control" style="width: 178px;">  

	<%while(subject_details.next()) {
		course_name = subject_details.getString("course_name");
		class_name = subject_details.getInt("class");
		subject_id = subject_details.getInt("subject_id");
		subject_name = subject_details.getString("subject_name");
		
		subject_full_name = subject_name + "("+class_name + " " + course_name+")";
	%>          
	       <option value="<%=subject_id%>"><%=subject_full_name%></option>
	<% }%>
</select>
</div>
</div>
</div>
 	 
<div id="batch_div" style="display: none">
<div class="form-group">
<label class="control-label col-sm-2" for="batch">BATCH:</label>
<div class="col-sm-10"> 
<select name="batch" class="form-control" class="batch" id="batch_name" style="width: 178px;" >  
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
          id="search_btn" onclick="result_table()" style="margin-top: 10%;margin-bottom: 10%;">
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
	System.out.println(e.getErrorCode());
}	
%>

<script>

function result_table() {
	var selected_type = document.getElementById("search_by").value;
	var data1 = data();
	var data2=null;
	if(selected_type == 'subject_and_batch') {
		data2 = document.getElementById("batch_name").value;	
	}
	
	$.ajax ({
		type: "POST",
		url: "faculty_search_results_for_delete.jsp",
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
	var faculty_no = document.getElementById("faculty_id_group");
	var first_name = document.getElementById("first_name_group");
	var last_name = document.getElementById("last_name_group");
	var subject = document.getElementById("subject_div");
	var batch = document.getElementById("batch_div");
	
	if(selected_type == "faculty_id") {
		faculty_no.style.display = "block";
		first_name.style.display = "none";
		last_name.style.display = "none";
		subject.style.display = "none";
		batch.style.display = "none";
			
	} else if(selected_type == "first_name") {
		faculty_no.style.display = "none";
		first_name.style.display = "block";
		last_name.style.display = "none";
		subject.style.display = "none";
		batch.style.display = "none";
		
	} else if(selected_type == "last_name") {
		faculty_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "block";
		subject.style.display = "none";
		batch.style.display = "none";
		
	} else if(selected_type == "subject_id") {
		faculty_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		subject.style.display = "block";
		batch.style.display = "none";		
		
	} else if(selected_type == "batch_name") {
		faculty_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		subject.style.display = "none";
		batch.style.display = "block";
	} else {
		faculty_no.style.display = "none";
		first_name.style.display = "none";
		last_name.style.display = "none";
		subject.style.display = "block";
		batch.style.display = "block";

	} 
}

function data() {
	var selected_type = document.getElementById("search_by").value;
	var faculty_no = document.getElementById("fac_id");
	var first_name = document.getElementById("fn");
	var last_name = document.getElementById("ln");
	var subject = document.getElementById("subject_id");
	var batch = document.getElementById("batch_name");
	var data;
	
	
	if(selected_type == "faculty_id") {
		data = faculty_no.value;
			
	} else if(selected_type == "first_name") {
		data = first_name.value;
		
	} else if(selected_type == "last_name") {
		data = last_name.value;

		
	} else if(selected_type == "subject_id") {
		data = subject.value;
		
		
	} else if(selected_type == "batch_name") {
		data = batch.value;

	} else {
		data = subject.value;
		
	} 	
	return data;
}
</script>

</body>
</html>	

