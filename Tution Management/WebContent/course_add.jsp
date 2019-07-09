<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
  <title> Add Course</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <style>
   body {
   font-family: Arial, Helvetica, sans-serif;
       /*background-image: url("bg.jpg");*/}
  .form-horizontal .control-label.text-left{
    text-align: left;
}     
  </style>
</head>

<body>

<%!
	Statement s;
	int course_id_alloted;
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
		ResultSet new_course_id = s.executeQuery("SELECT * FROM course ORDER BY course_id DESC limit 1;");
		if(new_course_id.next()) {
			course_id_alloted = new_course_id.getInt("course_id") + 1;
		}
		else
			course_id_alloted = 10001;
		
}catch(SQLException e) {
	System.out.println(e.getErrorCode());
}	
%>
 	
<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>Add Course: </strong>
                 </div>
  <div class="panel-body">
  <form class="form-horizontal" method="POST" action="course_add_database.jsp" >

       <div class="form-group">
      <label class="control-label col-sm-2" for="course_id">AUTO-GENERATED COURSE ID:</label>
      <div class="col-sm-10">          
        <input type="number" class="form-control" id="course_id"  name="course_id" value="<%=course_id_alloted %>" readonly>
      </div>
      </div> 
      
      <div class="form-group">
      <label class="control-label col-sm-2" for="course_name">COURSE NAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="course_name" placeholder="Enter course name" name="course_name">
      </div>
    </div>  
    
     <div class="form-group">
      <label class="control-label col-sm-2" for="class_name"> CLASS:</label>
      <div class="col-sm-10"> 
       <select name="class_name" class="form-control" style="width: 300px">  
       <%
       	ResultSet class_name = s.executeQuery("SELECT DISTINCT class FROM course;");
        while(class_name.next()) {
       %>
       <option ><%= class_name.getInt("class") %></option>
       <%} %>
       </select>
      </div>
     </div> 
    
      <div class="form-group">
      <label class="control-label col-sm-10 text-left" for="no_of_subjects">ENTER NO. OF SUBJECTS TO BE ADDED :</label>
      <div class="col-sm-offset-2 col-sm-10">          
        <input type="number" class="form-control" id="no_of_subjects"  name="no_of_subjects" onchange="addTextFields()">
      </div>
      </div>  
      
	  <div id="putter"></div>
      
      <div class="form-group">
      <label class="control-label col-sm-10 text-left" for="total_seats">TOTAL SEATS FOR COURSE :</label>
      <div class="col-sm-offset-2 col-sm-2">          
        <input type="number" class="form-control" id="total_seats"  name="total_seats">
      </div>
      </div>       
      
         <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-success btn-md btn-block" value="ADD" >ADD</button>
      </div> 
      </div>
  </form>
</div>
</div>
</div>
</div> 

<script>
	function addTextFields() {

		for(var i=1;i<=document.getElementById("no_of_subjects").value;i++) {
			var y = document.createElement("DIV");
			var a = document.createElement("DIV");	
			var b = document.createElement("INPUT");				
			var z = document.createElement("LABEL");
			var x = document.createElement("INPUT");
	    	//document.getElementById("putter").innerHTML = i;
			y.setAttribute("class", "form-group");
			y.setAttribute("id", i);

			document.getElementById("putter").appendChild(y);
	    	
			z.setAttribute("class", "control-label col-sm-2");	
			z.setAttribute("id", "label "+i);	
			document.getElementById(i).appendChild(z);	
	    	document.getElementById("label "+i).innerHTML = "Subject "+i;
	    	
	    	
			a.setAttribute("class", "col-sm-10");
			a.setAttribute("id", "inputdiv "+i);			
	    	document.getElementById(i).appendChild(a);
	    	
			x.setAttribute("type", "text");
			x.setAttribute("class", "form-control");
			x.setAttribute("name", "input_text "+i );
			x.setAttribute("id", "input_text "+i);
			x.setAttribute("placeholder", "Subject Name");
			document.getElementById("inputdiv "+i).appendChild(x);
			
			b.setAttribute("type", "number");
			b.setAttribute("min", "0");
			b.setAttribute("class", "form-control");
			b.setAttribute("name", "input_fees "+i );
			b.setAttribute("id", "input_fees "+i);
			b.setAttribute("placeholder", "Subject Fees");			
			document.getElementById("inputdiv "+i).appendChild(b);
			
		}
		
		document.getElementById("no_of_subjects").readOnly = true;

	}

</script>    
 
      
      
      
      
      
      
      
      
      
      
      