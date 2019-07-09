<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!
Statement s;
ResultSet parent;
int parent_id;
String selected_type, data1;

String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%>

<%
	selected_type = request.getParameter("selected_type");
	data1 = request.getParameter("data1");
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
        Class.forName("com.mysql.jdbc.Driver");
        
        input = getClass().getClassLoader().getResourceAsStream("db.properties");
        prop.load(input);

        url = prop.getProperty("url");
        uname = prop.getProperty("user");
        pass = prop.getProperty("password");

        con = DriverManager.getConnection(url, uname, pass);
            
        s = con.createStatement();
        if(selected_type.equals("p_name"))
        	parent = s.executeQuery("SELECT * FROM parent WHERE p_name like '%"+data1+"%';");
        else
        	parent = s.executeQuery("SELECT * FROM parent WHERE p_id = '"+data1+"';");
        	
%>
<% if(parent.next()) {%>

		<table border="1">
		<tr>
			<th>Select</th><th>Parent ID</th><th>Name</th><th>Email</th><th>Phone</th>		
		</tr>
<% do { %>
		<tr>
			<td><input type="checkbox" name="selected_records" value="<%=parent.getInt("p_id") %>"></input></td>
			<td> <%=parent.getInt("p_id") %> </td>
			<td> <%=parent.getString("p_name") %> </td>
			<td><%=parent.getString("email") %></td>
			<td><%=parent.getString("mobile") %></td>
	
		</tr>
<%}while(parent.next());%>		
		</table>
		
<input type="submit" value="Delete" 
onclick=" if (confirm('Are you sure you want to delete?')){this.form.action='parent_delete_results.jsp'; } else { return false; }">
</input> 

<%   
    }else {%>
    	No record found
    <%}
		con.close(); //close connection
    }
    catch(Exception e)
    {
        out.println(e);
    }
      
%>
      