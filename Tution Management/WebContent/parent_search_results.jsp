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
        	parent = s.executeQuery("SELECT * FROM parent,login WHERE uname = p_id AND p_name like '%"+data1+"%';");
        else
        	parent = s.executeQuery("SELECT * FROM parent,login WHERE uname = p_id AND p_id = '"+data1+"';");
        	
%>
<% if(parent.next()) {%>

		<table class="table table-striped table-bordered">
		<tr>
			<th>Parent ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Password</th>
		</tr>
<% do { %>
		<tr>
			<td> <%=parent.getInt("p_id") %> </td>
			<td> <%=parent.getString("p_name") %> </td>
			<td><%=parent.getString("email") %></td>
			<td><%=parent.getString("mobile") %></td>
			<td><%=parent.getString("pass") %></td>
	
		</tr>
<%}while(parent.next());%>		
		</table>

<%   
    }else {%>
<div class="col-sm-12 alert alert-warning">
<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
<h4>No record Found</h4>
</div>  
    <%}
		con.close(); //close connection
    }
    catch(Exception e)
    {
        out.println(e);
    }
      
%>
      