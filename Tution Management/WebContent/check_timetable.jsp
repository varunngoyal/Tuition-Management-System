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
		
 		if(!rs.next()) {
 			%>
 			<p style="color:red">Time Table not available</p>
 			<%
 		}
 		else {%>
 		<script>
 	document.getElementById("check_btn").style.display = "none";
 	var a = document.getElementById("batch").value;
 	document.getElementById("batch1").value = a;
 	
 	var b = document.getElementById("course").value;
 	document.getElementById("course1").value = b;
 	
 	document.getElementById("batch").disabled = true;	
 	document.getElementById("course").disabled = true;	
 	
 	var selected_batch = document.getElementById("batch");
	var value=7, am_pm="AM";
	var html = " ";
	var start_array=[];
	
	if(selected_batch.value == 'Morning') {
		start_array.push(7);
		start_array.push(8);
		start_array.push(9);
		start_array.push(10);
		
	}else if(selected_batch.value == 'Evening') {
		start_array.push(16);
		start_array.push(17);
				
	}

	for(var i=0; i<start_array.length; i++) {
		am_pm = "AM";
		value=start_array[i];
		
		if(start_array[i]>12) {
			value = start_array[i]-12;
			am_pm = "PM";
		}
		html += "<option value='"+start_array[i]+"'>"+value+":00 "+am_pm+"</option>";
	}
	
	//html += "<option value="+value+">"+value+":00 "+am_pm+"</option>";
	//html += "1";	
	for(var i=0;i<5;i++)
		document.getElementById("start_time"+i).innerHTML = html;
	</script>

	<p style="color: green">Time Table available for updating.</p>
 		
      <div class="form-group">
      <label class="control-label col-sm-2" for="batch">SELECT DAY:</label>
      <div class="col-sm-6"> 
       <select name="day" id="day" class="form-control" required>
        
       <option>Monday</option>
       <option>Tuesday</option>
       <option>Wednesday</option>
       <option>Thursday</option>
       <option>Friday</option>

       </select>
      </div>
     </div>

	<div class="day_container">
	<div class="day_header">
      <div class="form-group">
      <div class="col-sm-offset-2 col-sm-4">
       <select name="start_time<%=i%>" id="start_time<%=i %>" class="form-control">
       <option selected="true" disabled>Start Time</option>
       
       </select> 
      </div>
      <div class="col-sm-4">
        
       <input type="number" min="1" max="5" class="form-control" id="duration<%=i%>" 
       placeholder="Enter Total Duration" name="duration<%=i%>" oninput="create_table('<%=i%>')" required/>
      </div>
    </div>
    </div>
    
    <div id="table<%=i%>" class="table-class"></div>
    </div>
   
     
    <div class="form-group"> 
      <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-success btn-md btn-block" onclick="check()">UPDATE TIME TABLE</button>
      </div> 
    </div>		
		
		<%}
        con.close(); //close connection
    }
    catch(Exception e) {
    	out.println(e);
    }

%>
