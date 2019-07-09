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
<title>Fees Update</title>
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

<%!
	float total_fees, min_fees;
	ResultSet receipt;
	int receipt_value=0;
	Student_info obj = new Student_info();
	String[] subjects = null;
	int rows;
	int batch_identifier;
	String subjects_combo;
	Integer roll_no;
	
	ResultSet rs;

	int parent_id;
	String parent_id_str;
	
	Statement s;
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
parent_id_str = (String)session.getAttribute("uname");
parent_id = Integer.parseInt(parent_id_str);
try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    s=con.createStatement();
    rs = s.executeQuery("SELECT * FROM fees WHERE student_id IN"+
    " (SELECT roll_no FROM student WHERE parent_id = "+parent_id_str+" );");
	rs.next();
	
	if(rs.getInt("fees_due") == 0){
		%>
		<h1>You have already paid your fees</h1>
	<script>
	swal("Fees already paid!", "You have already paid your fees completely!", "warning");
	</script>
		<%
	}    else {

%>

<body>

<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>UPDATE FEES: </strong>
                 </div>
 <div class="panel-body">
 	<form class="form-horizontal" action="parent_update_fees_results.jsp" method="Post">
 	
        
        <input type="hidden" class="form-control" id="receipt_no" name="receipt_no" value="<%=rs.getInt("receipt_no") %>" readonly>
      
     <div class="form-group">
      <label class="control-label col-sm-2" for="total_fees">TOTAL FEES.:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="total_fees" name="total_fees" value="<%= rs.getInt("total_fees") %>" readonly>
      </div>
    </div>  
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="rem_fees">REMAINING FEES TO BE PAID:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="rem_fees" name="rem_fees" value="<%=rs.getInt("fees_due") %>" readonly>
      </div>
    </div>	 	
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="last_date_of_payment">PREVIOUS DATE OF PAYMENT:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="last_date_of_payment" name="last_date_of_payment"
         value="<%=rs.getString("date_of_payment")%>" readonly>
      </div>
    </div> 
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="date_of_payment"> DATE OF PAYMENT:</label>
      <div class="col-sm-10">          
            <%
         Date dNow = new Date( );
         SimpleDateFormat ft = 
         new SimpleDateFormat ("yyyy-MM-dd");
      %>
        <input type="text" class="form-control" id="date_of_payment" name="date_of_payment"
         value="<%=ft.format(dNow)%>" readonly>
      </div>
    </div> 
    
         <div class="form-group">
      <label class="control-label col-sm-2" for="fees_paid">PAY FEES.:</label>
      <div class="col-sm-10">          
        <input type="number" step="0.01" class="form-control" id="fees_paid" min =0 max="<%=rs.getInt("fees_due") %>" name="fees_paid">
      </div>
    </div> 	
    
       	<div class="form-group">
      <label class="control-label col-sm-2" for="mode_of_payment">MODE OF PAYMENT:</label>
      <div class="col-sm-10"> 
         <select id="mode_of_payment" class="form-control" name="mode_of_payment" >  
         <option>Cash</option>
         <option>Credit Card</option>
         <option>Debit Card</option>
         </select>
      	</div>
    	</div>	
    
             <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-success btn-md btn-block" value="PAY >>" >PAY >></button>
      </div> 
      </div>
    
    	
 	</form>
 	</div>
 	</div>
 	</div>
 	</div>
<%}
}catch(SQLException e) {
	e.printStackTrace();
}
con.close();
 %>
</body>
</html>