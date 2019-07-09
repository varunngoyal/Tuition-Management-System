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
<form method="post">
Search By: 
 
 <select name="search_by" id="search_by" onchange="select_input()">
	<option value="p_name">Name</option>
	<option value="p_id">Parent ID</option>

</select>  <br><br>
<input name="parent_id" type="number" id="parent_id" value="5000" placeholder="Parent Id" style="display: none" required> 
<input name="name" id="name" value="Parent Name" placeholder="Name"> 

<button id="search_btn" type="button" onclick="result_table()">Search</button>


<div id="putter">
</div>

</form>

<script>

function result_table() {
	var selected_type = document.getElementById("search_by").value;
	var data1 = data();

	$.ajax ({
		type: "POST",
		url: "parent_search_results_for_delete.jsp",
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
	var parent_id = document.getElementById("parent_id");
	var name = document.getElementById("name");
	
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