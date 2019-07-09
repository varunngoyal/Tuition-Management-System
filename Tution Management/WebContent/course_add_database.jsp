<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
   <title>Course Add Process</title>
</head>
<body>

<%!
	Statement s;
	String course_id, course_name, course_class,total_seats;
	int last_batch_id;
	int batch_year;
	
	int last_subject_id;
	int no_of_sub;
	String[] subjects = new String[1000];
	int[] fees = new int[1000];
	int var=0;
	
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

course_id = request.getParameter("course_id");
course_name = request.getParameter("course_name");
course_class = request.getParameter("class_name");
total_seats = request.getParameter("total_seats");
no_of_sub = Integer.parseInt(request.getParameter("no_of_subjects"));
for(int i=1;i<=no_of_sub;i++) {
	subjects[i-1] = request.getParameter("input_text "+i);
	fees[i-1] = Integer.parseInt(request.getParameter("input_fees "+i));
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
		
		//course insert
		s.executeUpdate("INSERT INTO course VALUES ("+course_id+",'"+ course_name+"',"+ course_class+");");
		
		//batch insert
		ResultSet batch_info = s.executeQuery("SELECT * FROM batch ORDER BY batch_id DESC LIMIT 1;");
		if(batch_info.next()) {
			last_batch_id = batch_info.getInt("batch_id");
			batch_year = batch_info.getInt("year");
			
		}
		else {
			batch_year = 2018;
			last_batch_id = 13000;
		}
		var=1;
		s.executeUpdate("INSERT INTO batch VALUES("+(last_batch_id+var)+", 'Morning',"+course_id+","+batch_year+", "+total_seats+", 0);");
		var++;
		s.executeUpdate("INSERT INTO batch VALUES("+(last_batch_id+var)+", 'Evening', "+course_id+","+batch_year+","+total_seats+", 0);");
		
		
		//subject insert
		ResultSet subject_info = s.executeQuery("SELECT * FROM subject ORDER BY subject_id DESC LIMIT 1;");
		if(subject_info.next()) {
			last_subject_id = subject_info.getInt("subject_id");
			
		}
		else {
			last_subject_id = 11000;
		}	

		for(int i=0;i<no_of_sub;i++) {
			var = i+1;
			s.executeUpdate("INSERT INTO subject VALUES ("+(last_subject_id+var)+",'"+ subjects[i]+"',"+ course_id+","+ fees[i]+");");
		}
		%>
	<script>
swal("Course added!", "Course added successfully!", "success");
</script>	
<%
		con.close();
}catch(SQLException e) {
	System.out.println(e);
}
//response.sendRedirect("course_add.jsp");
%>
</body>
</html>