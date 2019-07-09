<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!
Statement s;
ResultSet faculty;
String selected_type, data1, data2;

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
        if(selected_type.equals("subject_and_batch")) {
        	faculty = s.executeQuery("SELECT faculty_id, first_name, last_name,"+
        	" salary, address, dob, gender, mobile_no, years_of_exp FROM " +
        	"faculty WHERE faculty_id IN "+
        			
            "(SELECT distinct faculty_id"+
        	" FROM faculty_subject NATURAL JOIN faculty NATURAL JOIN faculty_batch"+
            " where batch_name = '"+data2+"' AND subject_id = "+data1+");");           	
        }
        else {
        	faculty = s.executeQuery("SELECT faculty_id, first_name, last_name,"+
        	" salary, address, dob, gender, mobile_no, years_of_exp FROM " +
        	"faculty WHERE faculty_id IN "+
        			
            "(SELECT distinct faculty_id"+
        	" FROM faculty_subject NATURAL JOIN faculty NATURAL JOIN faculty_batch"+
 		    " WHERE "+selected_type+" = '"+data1+"');");          
        }
%>
<% if(faculty.next()) {%>

		<table class="table table-striped table-bordered">
		<tr>
			<th></th><th>Faculty ID</th><th>First Name</th><th>Last Name</th>
			<th>Salary</th><th>Address</th><th>Date of Birth</th>
			<th>Gender</th><th>Mobile No.</th><th>Years of Exp.</th>		
		</tr>
<% do { %>
		<tr>

			<td>
            <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" name="selected_records" value="<%=faculty.getInt("faculty_id") %>"></input>	
              
            </div>
            
			</td>		
			<td> <%=faculty.getInt("faculty_id") %> </td>
			<td> <%=faculty.getString("first_name") %> </td>
			<td><%=faculty.getString("last_name") %></td>
			<td><%=faculty.getString("salary") %></td>
			<td><%=faculty.getString("address") %></td>
			<td><%=faculty.getString("dob") %></td>
			<td><%=faculty.getString("gender") %></td>
			<td style="width:150px"><%=faculty.getString("mobile_no") %></td>
			<td> <%=faculty.getString("years_of_exp") %></td>	
		</tr>
<%}while(faculty.next());%>		
		</table>

    <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-2">
         <button type="submit" class="btn btn-danger btn-md btn-block"
onclick=" if (confirm('Are you sure you want to delete?')){this.form.action='faculty_delete_results.jsp'; } else { return false; }"
         style="margin-top: 5%">
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
      