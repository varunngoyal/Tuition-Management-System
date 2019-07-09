<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%!

Statement s;
ResultSet faculty;

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

if(request.getParameter("subject_id")!=null) 
{
   
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
        faculty = s.executeQuery("SELECT * FROM faculty where faculty_id IN "+
        		"(SELECT DISTINCT faculty_id FROM faculty_subject NATURAL JOIN faculty NATURAL JOIN faculty_batch"+
        		" WHERE subject_id = "+request.getParameter("subject_id")+
        		" AND batch_name = '"+request.getParameter("batch_name")+"');");        
		if(!faculty.next()) {
			%> <b><i><font color="red">No faculty available</font></i></b><%
	        con.close(); //close connection
		}
		else {%>
		      <div class="form-group">
		      <label class="control-label col-sm-2" for="faculty">SELECT FACULTY:</label>
		      <div class="col-sm-10"> 
		       <select name="faculty" id="faculty" class="form-control">
		       <%
		       		 do{
		       %>         
		       <option value="<%=faculty.getInt("faculty_id") %>">
		       <%=faculty.getString("first_name")+" "+faculty.getString("last_name") %></option>
		       <%}while(faculty.next()); 
		       %>
		       </select>
		      </div>
		     </div>		
		<%}
		
        con.close(); //close connection
    }
    catch(Exception e)
    {%>
        <div class="col-sm-12 alert alert-danger">
		<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		<font size="3"><strong>Please select subject before proceeding!</strong></font>
		</div>
    <%}
}
%>
