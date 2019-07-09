<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Student Time Table</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<%!
Statement s;
String[] weekdays={"Monday","Tuesday","Wednesday","Thursday","Friday"};
int i=0;
String id;
int student_id;
String batch_name;
//String[] time = new String[100];
//String[] faculty_names = new String[100];
//String[] subject_names = new String[100];
//int[] duration = new int[10];
int start_time,end_time;

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

id = (String)session.getAttribute("uname");
student_id = Integer.parseInt(id);
System.out.println(id);
System.out.println(student_id);
try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
	Statement s=con.createStatement();
	ResultSet rs = s.executeQuery("SELECT * FROM batch WHERE batch_id IN (SELECT batch_id FROM student WHERE roll_no = "+student_id+");");
	if(!rs.next()) {
		%>
		<p color="red">Student Not found</p>
		<% 
		con.close();
	}
	
	batch_name = rs.getString("batch_name");
	if(batch_name.equals("Morning")) {
		start_time = 7;
		end_time = 14;
	}
	else {
		start_time = 16;
		end_time = 21;
	}
%>
<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> View Time Table</strong>
                 </div>
     <div class="panel-body">
		
		<table class="table">
		<thead>
		<tr>
			<th>#</th>
			<%for(int i=0;i<5;i++) { %>
			<th><%=weekdays[i]%></th>
			<%}%>
		</tr>
		</thead>
		<tbody>
		<%for(int i=start_time;i<=end_time;i++){ 
			String time_formatted = "";

			if(i>12) {
				time_formatted += (i-12)+":00 PM";
			} else {
				time_formatted += i + ":00 AM";
			}
			//time_formatted += " - "+(start_time+1)+":00 ";
			if(i+1>12) {
				time_formatted += " - "+(i-11)+":00 PM";
			} else {
				time_formatted += " - "+i+":00 AM";
			}			
			%>
			<tr>
			<td>
			<%=time_formatted %>
			</td>
			<%for(int j=0;j<5;j++) {
				ResultSet tt = s.executeQuery("SELECT * FROM subject NATURAL JOIN time_table NATURAL JOIN faculty WHERE "+
						"batch_name = '"+batch_name+"' AND day = '"+weekdays[j]+"' AND time = '"+i+":00:00' AND "+
						"subject_id IN (SELECT subject_id FROM student_subject WHERE student_roll_no ="+student_id+");");
				//System.out.println(batch_name);
				//System.out.println(weekdays[j]);
				//System.out.println(student_id);
				//System.out.println(i);

				if(tt.next()) {
					%>
					<td>
					<%=tt.getString("first_name")+ " "+tt.getString("last_name")%><br>
					<i><%=tt.getString("subject_name") %></i>
					</td>
					<%
				}else {
					%><td>  -  </td>
				<%}
				} %>
			</tr>
			</tbody>

	<%	} %>
	</table>
    </div>                              
   </div>
  </div>
</div>                 
<%
	con.close();
	
} catch(Exception e) {
    out.println("<div id=\"error\">");
    e.printStackTrace(new java.io.PrintWriter(out));
   out.println("</div>");
	System.out.println(e);
}%>