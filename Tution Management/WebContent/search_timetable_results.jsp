<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%!

Statement s;
String course,batch;
int i=0;
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;

String[] weekdays={"Monday","Tuesday","Wednesday","Thursday","Friday"};
int start_time,end_time;

%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

	course = request.getParameter("course");
	batch = request.getParameter("batch");   
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
 		ResultSet rs = s.executeQuery("SELECT * FROM time_table WHERE batch_name = '"+batch+"' AND subject_id IN "+
        "(SELECT subject_id FROM subject NATURAL JOIN course WHERE course_id = "+course+");");
		
 		if(batch.equals("Morning")) {
 			start_time = 7;
 			end_time = 14;
 		}
 		else {
 			start_time = 16;
 			end_time = 21;
 		}
 		
 		if(!rs.next()) {
 			%>
 			<p style="color:red">Time Table not available</p>
 			<%
 		}
 		else {%>
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
						"batch_name = '"+batch+"' AND day = '"+weekdays[j]+"' AND time = '"+i+":00:00' AND "+
						"subject_id IN (SELECT subject_id FROM subject WHERE course_id = "+course+");");
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
		<%}
        con.close(); //close connection
    }
    catch(Exception e) {
    	out.println(e);
    }

%>
 		