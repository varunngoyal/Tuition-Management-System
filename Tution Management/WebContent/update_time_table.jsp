<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Update Time Table</title>
  <style>
   body {font-family: Arial, Helvetica, sans-serif;
       background-image: url("bg5.jpg");}
   
  .day_container {
  	background-color: rgb(250, 250, 250);
  	transition-duration: 0.4s;
	box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2);
	border: 1px lightgray;
	margin-top: 20px;
	margin-bottom: 20px;
  } 
  
  .day_header {
  	padding-top: 20px;
  	padding-bottom: 7px;
	/* background-color: #189AD3; */
	/* color: white; */
	color: rgb(24, 105, 211);
	/*font-size: 40px;*/
	text-align: center;
	overflow: hidden;
	position: relative;
	border: 0px;
  }
  .table-class{
  	padding-left: 15%;
  	padding-right: 15%;
  	padding-bottom: 0.5%;
  	
  }
  .table-class table tbody tr td {
  	padding-top:15px;
  	padding-bottom:15px;

  }
  
  
  </style>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body onload="set_time()">
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
<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Update Time Table</strong>
                 </div>
     <div class="panel-body">
  	<form class="form-horizontal" id="form1" method="post" action="timetable_db_update">
  
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
      <div class="col-sm-offset-2 col-sm-4">
         <button type="button" class="btn btn-primary btn-md btn-block" id="check_btn" onclick="check()">CHECK IF AVAILABLE</button>
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

function create_table(i) {
	var i = i;
	var duration = document.getElementById("duration"+i).value;
	var start_time= document.getElementById("start_time"+i).value;
	var batch = document.getElementById("batch").value;
	var course = document.getElementById("course").value;;
	
    $.ajax({
		type: "POST",
		url: "add_time_table_process.jsp",
		data: { duration: duration,
				start_time: start_time,
				i_value: i,
				course: course,
				batch: batch
		},
		
		cache: false,
		success: function(response)
        {
            $("#table"+i).html(response);
        }
    });

}

function check() {

	var batch = document.getElementById("batch").value;
	var course = document.getElementById("course").value;;
	
    $.ajax({
		type: "POST",
		url: "check_timetable.jsp",
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

