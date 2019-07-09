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
<title>Administrator - Search Parent</title>
</head>
<body>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}
%>

<div class="container" style="margin-top: 5%">
  <div class="col-sm-12">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>SEARCH PARENT : </strong>
                 </div>
 <div class="panel-body">
<form method="post" onsubmit="return false;">
       <div class="form-group">
      <label class="control-label col-sm-2" for="search_by">Search By:</label>
      <div class="col-sm-10">  
 <select name="search_by" id="search_by" class="form-control" onchange="select_input()">
	<option value="p_name">Name</option>
	<option value="p_id">Parent ID</option>

</select> 
</div>
</div>
 <br><br>
 
 <div id="parent_id_group" style="display:none">
<div class="form-group">
<label class="control-label col-sm-2" for="parent_id"> PARENT ID:</label>
<div class="col-sm-8"> 
<input name="parent_id" min="5001" class="form-control" type="number" id="parent_id" value="5001" placeholder="Parent Id"> 
</div>
</div>
</div>

<div id="name_group">
<div class="form-group">
<label class="control-label col-sm-2" for="name"> NAME:</label>
<div class="col-sm-8"> 
<input name="name" id="name" class="form-control" placeholder="Name" required> 
</div>
</div>
</div>

	    <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-2">
         <button type="button" class="btn btn-primary btn-md btn-block"
          id="search_btn" onclick="result_table()" style="margin-top: 10%">
             <span class="glyphicon glyphicon-search"></span> Search</button>
      </div> 
    </div>
</form>

</div>
</div>
<div id="putter"></div>
</div>
</div>


<script>

function result_table() {
	var selected_type = document.getElementById("search_by").value;
	var data1 = data();

	$.ajax ({
		type: "POST",
		url: "parent_search_results.jsp",
		data: {selected_type: selected_type,
			   data1: data1},

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
	var parent_id = document.getElementById("parent_id_group");
	var name = document.getElementById("name_group");
	
	if(selected_type == "p_id") {
		parent_id.style.display = "block";
		name.style.display = "none";

			
	} else if(selected_type == "p_name") {
		parent_id.style.display = "none";
		name.style.display = "block";
		
	} 
}

function data() {
	var selected_type = document.getElementById("search_by").value;
	var parent_id = document.getElementById("parent_id");
	var name = document.getElementById("name");
	var data;
	
	if(selected_type == "p_id") {
		data = parent_id.value;
			
	} else if(selected_type == "p_name") {
		data = name.value;
		
	} 	
	return data;
}
</script>

</body>
</html>