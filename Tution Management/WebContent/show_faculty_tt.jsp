<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%!

Statement s;
String day;
int faculty_id;
int i=0;

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

	faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
	day = request.getParameter("day");
	
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        
        input = getClass().getClassLoader().getResourceAsStream("db.properties");
        prop.load(input);

        url = prop.getProperty("url");
        uname = prop.getProperty("user");
        pass = prop.getProperty("password");

        con = DriverManager.getConnection(url, uname, pass);
        
        s = con.createStatement();
%>
  <div class="col-sm-offset-3 col-sm-8">
<table class="table table-striped" style="width:100%">
<thead>
<tr>
<th>Time</th>
<th>Subject</th>
<th>Batch</th>
</tr>
</thead>
<tbody>
<%ResultSet rs = s.executeQuery("SELECT * FROM time_table NATURAL JOIN subject WHERE faculty_id = "+faculty_id+" AND day = '"+day+"';");
while(rs.next()) {%>
<tr>
<td><%=rs.getString("time") %></td>
<td><%=rs.getString("subject_name") %></td>
<td><%=rs.getString("batch_name") %></td>
</tr>
<%} %>
</tbody>

</table>
</div>



<%
        con.close(); //close connection
    }
    catch(Exception e) {
    	out.println(e);
    }

%>