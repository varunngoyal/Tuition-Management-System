<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Enquiry Process</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
     <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</head>
<body>
    
<%!
PreparedStatement ps = null;
	Statement s;
	String first_name ,last_name , email ,phone;
	
	
	String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;

	
	Connection con=null;	
%>
<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.



     

	//uname1 = Integer.parseInt(uname);
	first_name =  request.getParameter("first_name");
	last_name =  request.getParameter("last_name");
	email =  request.getParameter("email");
	phone =  request.getParameter("phone");


	
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    //Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/tution_project", "root","sadu@1999");

	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);

	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");
	    con = DriverManager.getConnection(url, uname, pass);

	     String sql = "insert into enquiry values (?, ?, ?,?);";

		ps = con.prepareStatement(sql);
		ps.setString(1,first_name);
		ps.setString(2,last_name);
		ps.setString(3,email);
		ps.setString(4,phone);
		int i = ps.executeUpdate();

		if(i > 0)
		{%>
			<script>
			swal("Sucessfully enrolled!", "enquiry details is sucessfully enrolled!", "success");
			</script>
		<%}
		else
		{%>
			<script>
			swal("Failed to enroll information");
			</script>
		<%} 

	}catch(SQLException e) {
		out.println(e);
	}

  
%>
</body>
</html>


