<%@page import="java.sql.*" %>
<%@page import="com.varun.jspex.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
	
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
   <title>Faculty Registration</title>
</head>
<body>
<%!
	Statement s;
	Faculty_info obj = new Faculty_info();
	String[] courses;
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

	obj.setFaculty_no(request.getParameter("faculty_id"));
	obj.setFirstname(request.getParameter("first_name"));
	obj.setLastname(request.getParameter("last_name")); 
	obj.setAddress(request.getParameter("address")); 
	obj.setDob(request.getParameter("DOB")); 
	obj.setPhone_no(request.getParameter("phone"));
	obj.setEmail(request.getParameter("email")); 
	obj.setGender(request.getParameter("gender")); 
	obj.setPassword(request.getParameter("pass"));
	System.out.println(request.getParameterValues("subjects_taught"));
	
	
	obj.setSubjects(request.getParameterValues("subjects_taught"));
	
	courses = request.getParameterValues("course");
	obj.setBatch(request.getParameterValues("batch"));
	
	obj.setQualification(request.getParameterValues("qualifications")); 
	
	//obj.setPhoto(request.getParameter("pic")); 
	obj.setSalary(request.getParameter("salary")); 
	obj.setYears_of_Exp(request.getParameter("years"));
	
	//try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    s = con.createStatement();
		s.executeUpdate(obj.insertFacultyLogin());
		s.executeUpdate(obj.insertFaculty());
		
		s.executeUpdate(obj.insertFacultySubject());
		s.executeUpdate(obj.insertFacultyQualification());
		s.executeUpdate(obj.insertFacultyBatch());
	
	//} catch(SQLException e) {
	//	System.out.println(e.getErrorCode());
	//}
	con.close();
%>
<script>
swal("Faculty registeration complete!", "Faculty registered successfully!", "success");
</script>

<% //response.sendRedirect("faculty_reg.jsp");%>
</body>
</html>