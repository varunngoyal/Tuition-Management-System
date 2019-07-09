<%@page import="java.sql.*" %>
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
<title>Registration Complete</title>
</head>
<body>
<%!
	Statement s;
	int receipt_no,roll_no;
	float total_fees, fees_paid, fees_due;
	String date_of_payment, mode_of_payment;
	
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

	receipt_no = Integer.parseInt(request.getParameter("receipt_no"));
	roll_no = (Integer)session.getAttribute("roll_no");
	total_fees = Float.parseFloat(request.getParameter("total_fees"));
	fees_paid = Float.parseFloat(request.getParameter("fees_paid"));
	fees_due = total_fees - fees_paid;  
	date_of_payment =  request.getParameter("date_of_payment");
	mode_of_payment = request.getParameter("mode_of_payment");
	
	Connection con = null;
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);

	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");

	    con = DriverManager.getConnection(url, uname, pass);
	    
		s = con.createStatement();
		
		s.executeUpdate("INSERT INTO fees VALUES ("+receipt_no+","+ roll_no+","+ total_fees+","+ fees_due+",'"+ date_of_payment+"','"+mode_of_payment+"');");
	}catch(SQLException e) {
		out.println(e);
	}
	//response.sendRedirect("student_reg.jsp");
	con.close();
%>
<script>
swal("Student registeration complete!", "Student registered successfully!", "success");
</script>
</body>
</html>


