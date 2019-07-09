<%@page import="java.sql.*" %>
<%@page import="com.varun.jspex.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.DateFormat" %> 
<%@page import="java.text.SimpleDateFormat" %> 
<%@page import="java.time.LocalDate" %> 
<%@page import="java.time.format.DateTimeFormatter" %> 
<%@page import="java.util.Calendar" %> 
<%@page import="java.util.Date" %> 

<!DOCTYPE html>
<html>
<head>
<title>Fees Module - Student Registration</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>  

<body>
<%!
	Statement s;
	float total_fees, min_fees;
	ResultSet receipt;
	int receipt_value=0;
	Student_info obj = new Student_info();
	String[] subjects = null;
	int rows;
	int batch_identifier;
	String subjects_combo;
	Integer roll_no;
	
	String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;
	Connection con=null;
	DateFormat sdf;
	
	Date dNow = new Date( );
    SimpleDateFormat ft;


%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

	total_fees = Float.parseFloat(request.getParameter("total_fees"));
	subjects_combo = request.getParameter("subjects_list");	
	subjects = subjects_combo.split("::");
	roll_no = (Integer)session.getAttribute("roll_no");
	min_fees = total_fees*40/100;
	obj.setPercentage(request.getParameter("x_percentage"));
	obj.setSchool_name(request.getParameter("school_name"));
	obj.setCourse(request.getParameter("course"));
	obj.setBatch(request.getParameter("batch"));
	
    LocalDate localDate = LocalDate.now();
    System.out.println(DateTimeFormatter.ofPattern("dd/MM/yyyy").format(localDate));
    
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);

	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");

	    con = DriverManager.getConnection(url, uname, pass);
	    s=con.createStatement();
		
		receipt = s.executeQuery("SELECT * FROM fees ORDER BY receipt_no desc LIMIT 1;");
		if(!receipt.next()) {
			receipt_value = 15001;
		}
		else {
			receipt_value = 1+receipt.getInt("receipt_no");
		}
		ResultSet batch_id = s.executeQuery(obj.getbatch_id());
		batch_id.next(); 
		batch_identifier = batch_id.getInt("batch_id");
		
		s.executeUpdate("UPDATE batch SET seats_occupied = seats_occupied+1 WHERE batch_id = "+batch_identifier+";");
		rows = s.executeUpdate(obj.updateStudent(  roll_no, batch_identifier ));
		s.executeUpdate(obj.insertSubjectStudents(subjects, roll_no));
	}catch(SQLException e) {
		System.out.println(e.getErrorCode());
	}
	con.close();
	
%>

<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>FEES MODULE: </strong>
                 </div>
 <div class="panel-body">
 	<form class="form-horizontal" action="hello.jsp" method="Post">
 
 	
     <div class="form-group">
      <label class="control-label col-sm-2" for="receipt_no">RECEIPT NO.:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="receipt_no" name="receipt_no" value="<%=receipt_value %>" readonly>
      </div>
    </div>		

     <div class="form-group">
      <label class="control-label col-sm-2" for="total_fees">TOTAL FEES.:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="total_fees" name="total_fees" value="<%= total_fees %>" readonly>
      </div>
    </div> 
 
    <div class="form-group">
      <label class="control-label col-sm-2" for="min_fees">MINIMUM FEES TO BE PAID:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="min_fees" name="min_fees" value="<%=min_fees %>" readonly>
      </div>
    </div>	 	
    
     <div class="form-group">
      <label class="control-label col-sm-2" for="fees_paid">PAY FEES.:</label>
      <div class="col-sm-10">          
        <input type="number" step="0.01" class="form-control" id="fees_paid" min = <%=min_fees %> max="<%=total_fees %>" name="fees_paid">
      </div>
    </div> 	
 
 	<script>
 	document.getElementById('date_of_payment').value = new Date().toDateInputValue();
 	</script>
    <div class="form-group">
      <label class="control-label col-sm-2" for="date_of_payment"> DATE OF PAYMENT:</label>
      <div class="col-sm-10">          
            <%
         Date dNow = new Date( );
         SimpleDateFormat ft = 
         new SimpleDateFormat ("yyyy/MM/dd");
      %>
        <input type="text" class="form-control" id="date_of_payment" name="date_of_payment"
         value="<%=ft.format(dNow)%>" readonly>
      </div>
    </div> 
 	
   	<div class="form-group">
      <label class="control-label col-sm-2" for="mode_of_payment">MODE OF PAYMENT:</label>
      <div class="col-sm-10"> 
         <select id="mode_of_payment" name="mode_of_payment" >  
         <option>Cash</option>
         <option>Credit Card</option>
         <option>Debit Card</option>
         </select>
      	</div>
    	</div>	

    <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-defaultx" value="next">REGISTER >> </button>
      </div>
    </div> 	
 	</form>
 </div>
 </div>
 </div>
 </div>
</body>
</html>

 