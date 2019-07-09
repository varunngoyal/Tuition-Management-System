<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>DELETE COURSE</title>
</head>
<body>

<%!
Statement s;
ResultSet course_details;
String course_name, course_full_name;
int course_id, class_name;
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

}catch(SQLException e) {
	System.out.println(e);
}	
%>

<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>DELETE COURSE</strong>
                 </div>
  <div class="panel-body">
  <form class="form-horizontal" method="POST" action="course_delete_process.jsp" >
   
    <div class="form-group">
      <label class="control-label col-sm-2" for="course">COURSE:</label>
      <div class="col-sm-10"> 
       <select name="course" id="course" class="form-control" style="width: 300px;">  
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
       <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-primary btn-md " style="width:30%" value="DELETE" 
         onclick=" if (confirm('Are you sure you want to delete?')){this.form.action='course_delete_process.jsp'; } else { return false; }">DELETE</button>
      </div> 
      </div> 
     
  </form>
</div>
</div>
</div>
</div>
</body>
</html>



