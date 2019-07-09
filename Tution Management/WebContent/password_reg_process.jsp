<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Password Changed</title>
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
	int uname1;
	String password;
	
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

     String uname = (String)session.getAttribute("uname");

	uname1 = Integer.parseInt(uname);
	password =  request.getParameter("pass");

	
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);

	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");

	    con = DriverManager.getConnection(url, uname, pass);
		ps = con.prepareStatement("Update login set pass = ?  where uname = ' " + uname1 + " ' ");
		ps.setString(1,password);
		int i = ps.executeUpdate();

		if(i > 0)
		{%>
			<script>
			swal("Password updated!", "password Updated Successfully!", "success");
			</script>
		<%}
		else
		{%>
			<script>
			swal("Failed updating password!", "There is a problem in updating password!", "error");
			</script>
		<%} 

	}catch(SQLException e) {
		out.println(e);
	}
/*	if (uname1 >=1  && uname1 <=5000)
	{
	   response.sendRedirect("finalstudentsection.jsp");
	}
	else if (uname1 >=5001  && uname1 <=10000)
	{
	   response.sendRedirect("finalfacultysection.jsp");
	}*/
	con.close();
%>
</body>
</html>


