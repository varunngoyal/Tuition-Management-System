<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!
	Statement s;
	String courses_selected;
	String[] courses;
	ResultSet i_subjects, course_name_rs;
	String subject_qualified, course_name;
	int course_class;
	
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

	courses_selected = request.getParameter("courses_selected");
	courses = courses_selected.split("::");
    Connection con=null;
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
      	
		for(int i=0;i<courses.length; i++) {

			course_name_rs = s.executeQuery("SELECT * FROM course WHERE course_id = "+courses[i]+";");
			course_name_rs.next();
			course_name = course_name_rs.getString("course_name");
			course_class = course_name_rs.getInt("class");
			i_subjects = s.executeQuery("SELECT * FROM subject WHERE course_id = "+ courses[i] +";");
		
			while(i_subjects.next()) {
				
				subject_qualified = i_subjects.getString("subject_name") + " ("+course_class+" "+course_name+")";
%>
	 	<option value="<%=i_subjects.getInt("subject_id") %>"><%=subject_qualified %></option>   
<%			
			}
		}
	con.close();
	
    }catch(SQLException e) {
    	System.out.println(e.getErrorCode());
    }    
%>     