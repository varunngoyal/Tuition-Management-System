<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<%!
Connection con=null;
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
%>
  	
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

try {
	Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);

	Statement s=con.createStatement();

   %>



<!DOCTYPE html>
<html>
  <head>
   <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Draw the pie chart for Sarah's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Draw the pie chart for the Anthony's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawChart1);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Course');
        data.addColumn('number', 'allotment');
        data.addRows([
        	<%ResultSet rs = s.executeQuery("select course_id, course_name, count(roll_no)"+
        " AS no_of_students,class FROM course NATURAL JOIN student GROUP BY course_id;");
			boolean hasNext = rs.next();
          	do {
			if(hasNext == false) break;
             if (hasNext) {%>
                 ['<%= rs.getInt("class")+" "+rs.getString("course_name") %>' , <%=rs.getInt("no_of_students")%>],
            <% }
             else {%>
                 ['<%= rs.getInt("class")+" "+rs.getString("course_name") %>' , <%=rs.getInt("no_of_students")%>]
             <%}
             hasNext = rs.next();
          }while(hasNext);%>
         
        ]);

        // Set chart options
        var options = {
                       'width':300,
                       'height':300,
					   'legend': {position: 'none'}
					   };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
      
      function drawChart1() {

          // Create the data table.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Subject');
          data.addColumn('number', 'Faculty');
          data.addRows([
          	<%ResultSet rs1 = s.executeQuery("select course_id,course_name,class,count(DISTINCT faculty_id) AS no_of_faculty"+
          " FROM faculty NATURAL JOIN faculty_subject NATURAL JOIN subject NATURAL JOIN course  GROUP BY course_id;");
  			boolean hasNext1 = rs1.next();
            	do {
  			if(hasNext1 == false) break;
               if (hasNext1) {%>
                   ['<%= rs1.getInt("class")+" "+rs1.getString("course_name") %>' , <%=rs1.getInt("no_of_faculty")%>],
              <% }
               else {%>
                   ['<%= rs1.getInt("class")+" "+rs1.getString("course_name") %>' , <%=rs1.getInt("no_of_faculty")%>]
               <%}
               hasNext1 = rs1.next();
            }while(hasNext1);%>
           
          ]);

          // Set chart options
          var options = {
                         'width':300,
                         'height':300,
  					   'legend': {position: 'none'}
  					   };

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.PieChart(document.getElementById('chart_div1'));
          chart.draw(data, options);
        }
    </script>
  </head>

  <body>
  <div style="margin-left: 4%">
  <h1>Statistics</h1>
  </div>
  <div class="container" style="margin-top: 5%">
  <div class="col-sm-4">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Course-wise student allotment</strong>
                 </div>
				   <div class="panel-body">
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
	</div>
	</div>
	</div>
  <div class="col-sm-4">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong> Course-wise faculty allotment</strong>
                 </div>
				   <div class="panel-body">
    <!--Div that will hold the pie chart-->
    <div id="chart_div1"></div>
	</div>
	</div>
	</div>
	</div>
	
<%}
finally {
    try {con.close();}catch(Exception e) {}
} 

%>
  </body>
</html>
