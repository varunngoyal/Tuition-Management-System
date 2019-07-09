<%@page import="java.sql.*" %>
<%@page import="com.varun.jspex.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date" %>
<%@page import="java.io.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>


<!DOCTYPE html>
<html>
<head>
<title>Fees Module - Student Registration</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script>
 	var x_discount=0;
 	var course_identifier;
	var i=0;

 	</script>
  <style>
  	#start {
  	color: red;
  	float: left;} 
  </style>
</head>
<body>
<%!
	Statement s;
	ResultSet course_details=null;
	ResultSet subjet_details=null;
	ResultSet batch_details=null;
	ResultSet specific_subject=null;
	String course_full_name;
	String course_name;
	int class_name;
	int course_id;
	
	String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;
	Connection con=null;
	
	DateFormat sdf;
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.

if(session.getAttribute("uname")==null)
{
	   response.sendRedirect("login.jsp");
}

	Student_info obj = new Student_info(); 
	obj.setPid(request.getParameter("username"));
	obj.setParent_pass(request.getParameter("parent_pass"));
	obj.setParent_repass(request.getParameter("parent_repass"));
	
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    
	    input = getClass().getClassLoader().getResourceAsStream("db.properties");
	    prop.load(input);

	    url = prop.getProperty("url");
	    uname = prop.getProperty("user");
	    pass = prop.getProperty("password");

	    con = DriverManager.getConnection(url, uname, pass);
	    
   		s=con.createStatement();
		s.executeUpdate(obj.updateParentLogin());	
		course_details = s.executeQuery(obj.selectCourse());
		

	}catch(SQLException e) {
		System.out.println(e.getErrorCode());
	}	
%>

<div class="container" style="margin-top: 5%">
  <div class="col-sm-offset-1 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong>FEES MODULE: </strong>
                 </div>
 <div class="panel-body">
  <form class="form-horizontal" method="POST" action="fees_final.jsp" >
<div class="col-sm-12 alert alert-info">
<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Info!</strong> If your percentage is more than <strong>90%</strong>, you will get a 10% discount
</div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="x_percentage"><span>&#8553;</span> PERCENTAGE:</label>
      <div class="col-sm-10">          
        <input type="number" step="0.01" max="100" min="0" class="form-control" id="x_percentage" name="x_percentage" onchange = "x_discount()">
      </div>
    </div>
    <div class="col-sm-12 alert alert-info">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Info!</strong> Please specify the <strong>school</strong> from which you passed<span>&#8553;</span> board exam. 
</div>    
    <div class="form-group">
      <label class="control-label col-sm-2" for="school_name"> SCHOOL NAME:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="school_name" name="school_name" >
      </div>
    </div>    

 
     <div class="form-group">
      <label class="control-label col-sm-2" for="course">COURSE:</label>
      <div class="col-sm-10"> 
       <select name="course" id="course_select" class="form-control" onchange="displaySubjects()">  
       <option >-----select course------</option>    
<%while(course_details.next()) { 
	course_name = course_details.getString("course_name");
	class_name = course_details.getInt("class");
	course_id = course_details.getInt("course_id");
	course_full_name = class_name + " " + course_name;
%>          
       <option value="<%=course_id%>"><%=course_full_name%></option>
<% }%>
       </select>
      </div>
     </div>   
    <div class="col-sm-12 alert alert-info">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Info!</strong> If you select all subjects you get a 5% discount
</div>        
   	<div class="form-group">
      <label class="control-label col-sm-2" for="subject">SELECT ONE OR MORE SUBJECTS WITH FEES:</label>
      <div class="col-sm-10"> 
         <select name="subject" class="form-control" id="subject_select" onchange="fp_discount()" multiple>  
         </select>
      	</div>
    	</div>
    	
    <div class="col-sm-12 alert alert-info">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Info!</strong> If you are register early, then you get 5% discount!
</div>     
     	
      <div class="form-group">
      <label class="control-label col-sm-2" for="batch">SELECT BATCH:</label>
      <div class="col-sm-10"> 
       <select name="batch" id="batch_select" class="form-control" onchange = "batch_change()">
       <option>------select batch-------</option>
       <%
       		batch_details = s.executeQuery("SELECT DISTINCT batch_name FROM batch;");
       		while(batch_details.next()) {
       %>         
       <option><%=batch_details.getString("batch_name") %></option>
       <%} 
       %>
       </select>
      </div>
     </div>  	
    
     
    <div class="form-group">
      <label class="control-label col-sm-2" for="base_fees"> BASE FEES:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="base_fees" name="base_fees" value=0 readonly>
      </div>
    </div>     
  <div class="alert alert-success" id="discount_msg" hidden>
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Success!</strong> You get a 10% discount for scoring more than or equal to 90% in <span>&#8553;</span> board exam. 
</div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="x_percentage"><span>&#8553;</span> PERCENTAGE DISCOUNT:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="x_perc_discount" name="x_perc_discount" value="0%" readonly>
      </div>
    </div> 
  <div class="col-sm-12 alert alert-success" id="subject_discount_msg" hidden>
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Success!</strong> You get a 5% discount for enrolling for complete course!
</div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="x_percentage">FULL PACKAGE DISCOUNT:</label>
      <div class="col-sm-10">          
        <input type="text" class="form-control" id="full_pack_discount" name="full_pack_discount" value="0%" readonly>
      </div>
    </div> 
    
    <p id="putter"></p>
    
         <input id="subjects_list" name="subjects_list" value="hiddenValue" hidden>
     
    

    
  </form>
  </div>
  </div>
  </div>
  </div>	

<script>
function displaySubjects() {

	var course_identifier = $("#course_select").val();
    $.ajax({
		type: "POST",
		url: "subject.jsp",
		data: "course_identifier="+course_identifier,
		cache: false,
		success: function(response)
        {
            $("#subject_select").html(response);
        }
    });
    return course_identifier;

}

function x_discount() {
	var x_discount = 0;
	var x_percentage = document.getElementById("x_percentage").value;
	var discount_msg = document.getElementById("discount_msg");
	
	if(x_percentage >= 90) {
		x_discount = 10;
		discount_msg.style.display = "block";
		
	}else {
		discount_msg.style.display = "none";
	}
	
	document.getElementById("x_perc_discount").value = x_discount + "%";
	return ;
}

function fp_discount() {
	//var options1 = document.getElementById("subject_select").options.length;	
	//BE VERY CAREFUL DO NOT ASSIGN length PROPERTY TO A VARIABLE BECAUSE IT IS READ ONLY
	document.getElementById("base_fees").value = "0";
	var sub_discount_msg = document.getElementById("subject_discount_msg");


	var array = [];
	
	var sum_str=0;
	var sum = parseInt(sum_str,10);
	for (var i=0; i < document.getElementById("subject_select").options.length; i++) {
		
		if(document.getElementById("subject_select").options[i].selected) {	
			
			var subject_code =document.getElementById("subject_select").options[i].text;
			var firstindex = subject_code.indexOf("(");
			var secondindex = subject_code.indexOf(")");
			var subject_fees = subject_code.slice(firstindex+1, secondindex);
			var subject_fees_int = parseInt(subject_fees, 10);
			sum+=subject_fees_int;
			array.push(document.getElementById("subject_select").options[i].value);
		}
	}	
	
	document.getElementById("subjects_list").value=array.join("::");
	
	document.getElementById("base_fees").value = sum;
	document.getElementById("full_pack_discount").value = 0+"%";	
	var count = 0;
	 //var total_length = $("#subject_select > option").val;
	
	 var full_pack_discount = 0;

	for (var i=0; i < document.getElementById("subject_select").options.length; i++) {
	  if (!document.getElementById("subject_select").options[i].selected) 
	  {
		  sub_discount_msg.style.display = "none";
		  return ; 
	  }  
	}
	 sub_discount_msg.style.display = "block";
	document.getElementById("full_pack_discount").value = 5 + "%";	
}



function batch_change() {
	var batch_name = $("#batch_select").val();
	var sum = 0;
	var course_identifier;

	var x_perc_str = document.getElementById("x_perc_discount").value; 
	var x_perc = parseInt(x_perc_str.slice(0,-1), 10);

	var x_full_pack_str = document.getElementById("full_pack_discount").value; 
	var x_full_pack = parseInt(x_full_pack_str.slice(0,-1), 10);	

	sum = x_perc + x_full_pack;
	var base_fees = document.getElementById("base_fees").value;
	
    $.ajax({
		type: "POST",
		url: "discount.jsp",
		data: {course_identifier: displaySubjects(),
			batch_name: batch_name,
			sum: sum,
			base_fees: base_fees},
		cache: false,
		success: function(response)
        {
            $("#putter").html(response);
        }
    });		
}

</script>

</body>
</html>







