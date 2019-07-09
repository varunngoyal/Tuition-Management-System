<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!
	Statement s;
	String str;
	int course_id;
	String batch_name;
	float sum_until_now, total_discount;
	ResultSet specific_batch;
	int seats_occupied,total_seats;
	int early_bird_discount = 0;
	float base_fees, total_fees;
	String output;
	
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

try
{
	str = request.getParameter("course_identifier");	
	course_id = Integer.parseInt(str);
	batch_name = request.getParameter("batch_name");
	sum_until_now = Float.parseFloat(request.getParameter("sum"));
	base_fees = Float.parseFloat(request.getParameter("base_fees"));
	
	System.out.println(str);
	System.out.println(batch_name);
    
	Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    s = con.createStatement();
    
    specific_batch = s.executeQuery("SELECT * FROM batch WHERE course_id = "+course_id+" AND batch_name = '"+batch_name+"'; ");
    
    specific_batch.next();
    
    seats_occupied = specific_batch.getInt("seats_occupied");
    
    total_seats = specific_batch.getInt("total_seats");
    
    if(seats_occupied < total_seats*20/100) {
    	early_bird_discount = 5;
    }
    
    total_discount = sum_until_now + early_bird_discount;
    total_fees = base_fees*(1-(total_discount/100));
    //output = early_bird_discount+" "+ (total_seats - seats_occupied);

%>
	<%
	if(total_seats<=seats_occupied) { %>
		<div class="col-sm-12 alert alert-info">
		<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		<strong>Sorry</strong> the batch is full with size <%=total_seats%><br/>
		Either select another batch or cancel your registration here
		</div>
		<script>
		document.getElementById("proceed").disabled = true;
		</script>
	<div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-4">
		<a href="cancel_student_reg.jsp" class="btn btn-danger btn-block btn-md" role="button" aria-pressed="true">CANCEL REGISTRATION</a>
		
      </div> 
    </div>

	
	<%} %>
	<%if(early_bird_discount >0) { %>
	  <div class="col-sm-12 alert alert-success" id="early_discount_msg" hidden>
	  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  			<strong>Success!</strong> You get a 5% discount for early enrollment!
		</div>
	<% }%>

    <div class="form-group">
      <label class="control-label col-sm-2" for="eb_discount">EARLY BIRD DISCOUNT:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="eb_discount" name="eb_discount" value="<%=early_bird_discount + "%" %>" readonly/>
      </div>
    </div>

    <div class="form-group">
      <label class="control-label col-sm-2" for="total_discount">TOTAL DISCOUNT:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="total_discount" name="total_discount" value="<%=total_discount+"%" %>" readonly/>
      </div>
    </div>

    <div class="form-group">
      <label class="control-label col-sm-2" for="total_fees">TOTAL FEES:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="total_fees" name="total_fees" value="<%=total_fees %>" readonly/>
      </div>
    </div>    
    
    <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" id="proceed" class="btn btn-defaultx" value="next">PROCEED TO PAY FEES >> </button>
      </div>
    </div>    
<%
con.close(); //close connection

} catch(Exception e)
{
e.printStackTrace();
}
%>