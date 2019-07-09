<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%!

Statement s;
int start_time,duration,i;
String batch, course;
String time_formatted;
int j;
int new_time;
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;

public String get_time(int start_time) {
	if(start_time>12)
	{	
		int value1 = start_time-12;
		int value2 = value1 + 1;
		time_formatted = value1+" :00 PM - "+value2+":00 PM";
	}
	else {
		int value1 = start_time+1;
		time_formatted = start_time+" :00 AM - "+value1+":00 AM";
	}
	return time_formatted;
}
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

	start_time = Integer.parseInt(request.getParameter("start_time"));
	duration = Integer.parseInt(request.getParameter("duration"));
	course = request.getParameter("course");
	batch = request.getParameter("batch");
	i = Integer.parseInt(request.getParameter("i_value"));
	
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

 		<table class="table">   
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">Time</th>
		      <th scope="col">Subject</th>
		      <th scope="col">Faculty</th>
		    </tr>
		  </thead>
		  
		  <tbody id="tbody<%=i%>">
		  <%for(int j=0;j<duration;j++) { %>
			<tr>
			<%new_time = start_time+j; %>
			
		 	<td width="30%" >
		 	<input type="hidden" value="<%=new_time+":00:00"%>" name="realtime<%=i%><%=j%>"/>
		 	<%=get_time(start_time+j) %>
		 	</td>
		 	
		 	<td width="38%">
		 	<div>
		         <select id="subjects" class="form-control" name="subjects<%=i%><%=j%>" onchange="getfaculty('<%=j%>')"> 
					<%ResultSet rs = s.executeQuery("SELECT * FROM subject natural join course WHERE course_id = "+course+";");
					%>  		
					<option selected="true" disabled>Select subject</option>
					<%
					while(rs.next()) {%>  
				  	        
				         <option value = " <%=rs.getInt("subject_id") %>">
				         <%=rs.getString("subject_name") %>
				         </option>
					<%} %>
		         </select>
         </div>
		 	</td>
		 	<td width="33%" id="faculty<%=i%><%=j%>">
		 	
		 	</td>
		 	</tr>
		 	<%} %>
 		  </tbody>
		</table>
         
<%
        con.close(); //close connection
    }
    catch(Exception e)
    {%>
        <font color="red"><u><i><p>Please select subject before proceeding</p></i></u></font>
    <%}

%>
<script>
function getfaculty(j) {
	var subject_id = document.getElementById("subjects").value;
	var batch_name = document.getElementById("batch").value;
	var i = <%=i%>;
	
    $.ajax({
		type: "POST",
		url: "getfaculty_for_timetable.jsp",
		data: { subject_id:subject_id,
			    batch_name: batch_name,
			    i_value: i,
			    j_value: j
		},
		
		cache: false,
		success: function(response)
        {
            $("#faculty"+i+""+j).html(response);
        }
    });
	
}
</script>         