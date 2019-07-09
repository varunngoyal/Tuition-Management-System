<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>    
<!DOCTYPE html>
<html>
<head>
	<title>Add test</title>
	<meta charset="ISO-8859-1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script type="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker.css"></script>
</head>
<body onload="getfaculty()">

<%!
	Statement s = null;
	int test_id_alloted;
	String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;
	//FileInputStream fs;
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
	    
	    //fs = new FileInputStream(System.getProperty("user.dir")+"\\db.properties");
	    //prop.load(fs);
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);
	
	    url = prop.getProperty("url");
	    //url = url.trim();
	    uname = prop.getProperty("user");
	    //uname.trim();
	    pass = prop.getProperty("password");
	    //pass.trim();
	    
	    System.out.println(url);
	    System.out.println(uname);
	    System.out.println(pass);
	
	    con = DriverManager.getConnection(url, uname, pass);
	    
		s=con.createStatement();
		
		ResultSet get_test_id = s.executeQuery("SELECT * FROM test ORDER BY test_id DESC LIMIT 1;");
		
		if(get_test_id.next()) {
		
			test_id_alloted = get_test_id.getInt("test_id")+1;
		}else {
			
			test_id_alloted = 25001;
		}
		

%>

 
<div class="container" style="margin-top: 5%">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>Add Test: </strong>
                 </div>
  <div class="panel-body">
  <form class="form-horizontal" method="POST" action="test_add_database.jsp" >
  
       <div class="form-group">
      <label class="control-label col-sm-2" for="course_id">AUTO-GENERATED TEST ID:</label>
      <div class="col-sm-10">          
        <input type="number" class="form-control" id="test_id"  name="test_id" value="<%=test_id_alloted %>" readonly>
      </div>
      </div> 

      <div class="form-group">
      <label class="control-label col-sm-2" for="batch">SELECT BATCH:</label>
      <div class="col-sm-10"> 
       <select name="batch" id="batch" class="form-control" onchange="getfaculty()">
       <%
       		ResultSet batch_details = s.executeQuery("SELECT DISTINCT batch_name FROM batch;");
       		while(batch_details.next()) {
       %>         
       <option><%=batch_details.getString("batch_name") %></option>
       <%} 
       %>
       </select>
      </div>
     </div>
      
   	<div class="form-group">
      <label class="control-label col-sm-2" for="subjects">TEST ON SUBJECT:</label>
      <div class="col-sm-10"> 
         <select id="subjects" class="form-control" name="subjects" onchange="getfaculty()"> 
	<%ResultSet rs = s.executeQuery("SELECT * FROM subject natural join course;");
	%>  		
	<option selected="true" disabled>Select subject</option>
	<%
	while(rs.next()) {%>  
  	        
         <option value = " <%=rs.getInt("subject_id") %>">
         <%=rs.getString("subject_name")+" ("+rs.getString("class")+" "+rs.getString("course_name")+")" %>
         </option>
	<%} %>
         </select>
      	</div>
    	</div>	
      
	<div id="putter"></div>
	
	<div class="form-group">
      <label class="control-label col-sm-2" for="max_score">MAX SCORE :</label>
      <div class="col-sm-2">          
        <input type="number" class="form-control" min="30" max="100" id="max_score"  name="max_score" required>
      </div>	
      </div>  
      
    <div class="form-group">
      <label class="control-label col-sm-2" for="date_of_test">TEST ON:</label>
      <div class="col-sm-10">          
        <input type="date" class="form-control" id="date_of_test" name="date_of_test" required>
      </div>
    </div> 
          
    <div class="form-group">
      <label class="control-label col-sm-2" for="time_of_test">TEST ON:</label>
      <div class="col-sm-10">          
        <input type="time" class="form-control" id="time_of_test" name="time_of_test" required>
      </div>
    </div>           

    <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-success btn-md btn-block" value="ADD TEST" >ADD TEST</button>
      </div> 
    </div>

  </form>
</div>
</div>
</div>
</div> 

<script>
function getfaculty() {
	var subject_id = document.getElementById("subjects").value;
	var batch_name = document.getElementById("batch").value;
	
    $.ajax({
		type: "POST",
		url: "getfaculty.jsp",
		data: { subject_id:subject_id,
			    batch_name: batch_name
		},
		
		cache: false,
		success: function(response)
        {
            $("#putter").html(response);
        }
    });
	
}
</script>
<%
	con.close();
}catch(SQLException e) {
	
	e.printStackTrace();
}%>	
</body>
</html>