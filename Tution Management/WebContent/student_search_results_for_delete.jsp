<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!
Statement s;
ResultSet student;
int roll_no;
String selected_type, data1, data2;
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
	//roll_no = Integer.parseInt(request.getParameter("roll_no"));
	selected_type = request.getParameter("selected_type");
	data1 = request.getParameter("data1");
	data2 = request.getParameter("data2");

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
        if(selected_type.equals("course_and_batch")) {
     		student = s.executeQuery("SELECT roll_no, first_name, last_name, email, phone, DOB, gender, "+
						"address, college_name, batch_name, class, course_name,tenth_perc FROM"+
						" student NATURAL JOIN batch NATURAL JOIN course WHERE course_id ="+data1+" AND batch_name = '"+data2+"';");           	
        }
        else {
 			student = s.executeQuery("SELECT roll_no, first_name, last_name, email, phone, DOB, gender, "+
 						"address, college_name, batch_name, class, course_name,tenth_perc FROM"+
 						" student NATURAL JOIN batch NATURAL JOIN course WHERE "+selected_type+" = '"+data1+"';");          
        }
%>
<% if(student.next()) {%>

		<table class="table table-striped">
		<tr>
			<th>Select</th>
			<th>Roll No.</th><th>First Name</th><th>Last Name</th>
			<th>Email</th><th>Phone</th><th>Date of Birth</th>
			<th>Gender</th><th>Address</th><th>College Name</th>
			<th>Batch</th><th>Class</th><th>Course</th>
			<th>X %</th>		
		</tr>
<% do { %>
		<tr>
			<td><input type="checkbox" name="selected_records" value="<%=student.getInt("roll_no") %>"></input></td>
			<td> <%=student.getInt("roll_no") %> </td>
			<td> <%=student.getString("first_name") %> </td>
			<td><%=student.getString("last_name") %></td>
			<td><%=student.getString("email") %></td>
			<td><%=student.getString("phone") %></td>
			<td><%=student.getString("DOB") %></td>
			<td><%=student.getString("gender") %></td>
			<td style="width:150px"><%=student.getString("address") %></td>
			<td> <%=student.getString("college_name") %></td>
			<td><%=student.getString("batch_name") %></td>
			<td><%=student.getInt("class") %></td>
			<td><%=student.getString("course_name") %></td>
			<td><%=student.getInt("tenth_perc") %></td>		
		</tr>
<%}while(student.next());%>		
		</table>
		
    <div class="form-group"> 
      <div class=" col-sm-3">
         <button type="submit" class="btn btn-danger btn-md btn-block"
         onclick=" if (confirm('Are you sure you want to delete?')){this.form.action='student_delete_results.jsp'; } else { return false; }"
         style="margin-top: 10%">
         DELETE</button>
      </div> 
    </div>		


<% 
    }else {%>
<div class="col-sm-12 alert alert-warning">
<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
<h4>No record Found</h4>
</div>     <%}
		con.close(); //close connection
    }
    catch(Exception e)
    {
        out.println(e);
    }
      
%>
    