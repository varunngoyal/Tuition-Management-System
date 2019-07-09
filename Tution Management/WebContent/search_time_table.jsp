<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Update Time Table</title>
    <style>
   body {font-family: Arial, Helvetica, sans-serif;}
   </style>
   
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<%!
Statement s;
String[] weekdays={"Monday","Tuesday","Wednesday","Thursday","Friday"};
int i=0;
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
	Statement s=con.createStatement();

%>
<div class="container" style="top-margin:5%;">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Search Time Table</strong>
                 </div>
     <div class="panel-body">
  	<form class="form-horizontal" id="form1" method="post">
  	    <div class="form-group">
      <label class="control-label col-sm-2" for="course">COURSE:</label>
      <div class="col-sm-10"> 
       <select name="course" id="course" class="form-control">  
	<%	ResultSet course_details = s.executeQuery("SELECT * FROM course;");

	while(course_details.next()) { %>
	          
       <option value="<%=course_details.getInt("course_id")%>">
       <%=course_details.getInt("class") + " " + course_details.getString("course_name")%></option>
	<% }%>
       </select>
      </div>
     </div>  
		 	
		 	
      <div class="form-group">
      <label class="control-label col-sm-2" for="batch">SELECT BATCH:</label>
      <div class="col-sm-10"> 
       <select name="batch" id="batch" class="form-control">
       <%
       		ResultSet batch_details = s.executeQuery("SELECT DISTINCT batch_name FROM batch;");
       		while(batch_details.next()) {
       %>         
       <option value="<%=batch_details.getString("batch_name")%>">
       <%=batch_details.getString("batch_name") %></option>
       <%} 
       %>
       </select>
      </div>
     </div>
     
     <input type="hidden" id="batch1" name="batch1">
     <input type="hidden" id="course1" name="course1">
     
         <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-2">
         <button type="button" class="btn btn-primary btn-md btn-block" id="check_btn" onclick="search()">
         <span class="glyphicon glyphicon-search"></span> Search</button>
      </div> 
    </div>
    
        		<div class="container-main"></div>
             
      </form>
    </div>                              
   </div>
  </div>
</div>                 
<%
	con.close();
	
} catch(Exception e) {
	out.println(e);
}%>
<script>
function search() {

	var batch = document.getElementById("batch").value;
	var course = document.getElementById("course").value;;
	
    $.ajax({
		type: "POST",
		url: "search_timetable_results.jsp",
		data: { 
				course: course,
				batch: batch
		},
		
		cache: false,
		success: function(response)
        {
            $(".container-main").html(response);
        }
    });
}
</script>
</body>
</html>