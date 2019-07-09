<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Faculty Time Table</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<%!
String url,uname, pass;
String faculty_str;
int faculty_id;
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

faculty_str = (String)session.getAttribute("uname");
faculty_id = Integer.parseInt(faculty_str);
try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    Statement s=con.createStatement();
	
%>

<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> View Time Table by Day</strong>
                 </div>
     <div class="panel-body">
     <form class="form-horizontal">
      
      <div class="form-group">
      <label class="control-label col-sm-2" for="batch">SELECT DAY:</label>
      <div class="col-sm-6"> 
       <select name="day" id="day" class="form-control" required>
        
       <option>Monday</option>
       <option>Tuesday</option>
       <option>Wednesday</option>
       <option>Thursday</option>
       <option>Friday</option>

       </select>
      </div>
     </div>
     
         <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-4">
         <button type="button" class="btn btn-primary btn-md btn-block" onclick="showtt()">SHOW TIME TABLE</button>
      </div> 
    	</div>
    	  
   </form>                            
   </div>
  </div>
</div>  
</div>
<div id="putter"></div>
<%
	con.close();
	
} catch(Exception e) {
    out.println("<div id=\"error\">");
    e.printStackTrace(new java.io.PrintWriter(out));
   out.println("</div>");
	System.out.println(e);
}%>
<script>
function showtt() {

	var day = document.getElementById("day").value;;
	
    $.ajax({
		type: "POST",
		url: "show_faculty_tt.jsp",
		data: { 
				day: day,
				faculty_id: <%=faculty_id%>
		},
		
		cache: false,
		success: function(response)
        {
            $("#putter").html(response);
        }
    });
}
</script>
</body>
</html>