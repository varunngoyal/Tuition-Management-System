<!DOCTYPE html>
<html>
<title>SUCCESS TUTORIALS</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>

.w3-sidebar a {font-family: 'Arial', sans-serif;}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}

body {
    /*background-image: url("schoolbg2.jpg");*/
}
iframe {
	position: absolute;
	right:0;
	top:100%;
}

</style>

<body class="w3-content" style="max-width:1200px">
<%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        
    if(session.getAttribute("uname")==null)
        {
      	   response.sendRedirect("login.jsp");
        }
%>
<!-- Sidebar/menu -->
<nav class="w3-padding-64 w3-sidebar w3-bar-block w3-teal w3-collapse w3-top " style="z-index:3;width:20%;position: absolute;left:0" id="mySidebar">
  <div class="w3-container w3-display-container w3-padding-12">
    <i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
    <h3 class="w3-wide" style="margin-bottom:15%"><b><center>SUCCESS TUTORIALS</center></b></h3>
  </div>
  
  
  <div class="w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc()" href="javascript:void(0)" class="w3-button w3-block w3-teal w3-left-align" id="myBtn">
      Student <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="student_reg.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Add a student</a>
       <a href="student_search.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Search a student</a>
        <a href="student_delete.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Delete a student</a>
    </div>
 </div>
        
     <div class="w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc1()" href="javascript:void(0)" class="w3-button w3-block w3-teal  w3-left-align" id="myBtn1">
      Parent <i class="fa fa-caret-down"></i>
    </a>    
     <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
       <a href="parent_search.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Search a parent</a>
        <!-- <a href="parent_delete.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Delete a parent</a> -->
    </div>
    </div>
    
     <div class=" w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc2()" href="javascript:void(0)" class="w3-button w3-block w3-teal w3-left-align" id="myBtn2">
      Faculty <i class="fa fa-caret-down"></i>
    </a>    
     <div id="demoAcc2" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="faculty_reg.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Add a faculty</a>
       <a href="faculty_search.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Search a faculty</a>
        <a href="faculty_delete.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Delete a faculty</a>
    </div>
    </div>
    
  <div class=" w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc3()" href="javascript:void(0)" class="w3-button w3-teal w3-block w3-left-align" id="myBtn">
      Course <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc3" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="course_add.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Add a course</a>
        <a href="course_delete.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Delete a course</a>
    </div>    
  </div>
  
  <div class=" w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc4()" href="javascript:void(0)" class="w3-button w3-teal w3-block w3-left-align" id="myBtn">
      Test <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc4" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="test_add.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Add a test</a>
    </div>      
  </div>

  <div class=" w3-large w3-text-grey" style="font-weight:bold">
   <a onclick="myAccFunc5()" href="javascript:void(0)" class="w3-button w3-teal w3-block w3-left-align" id="myBtn">
      Time Table <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc5" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="add_time_table.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Add time table</a>
      <a href="update_time_table.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Update time table</a>
      <a href="search_time_table.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Search time table</a>
      <a href="delete_time_table.jsp" target="admini" class="w3-bar-item w3-button w3-blue"><i class="fa fa-caret-right w3-margin-right"></i>Delete time table</a>

    </div>      
  </div>
  
<a href="enquiry.jsp" target="admini" class="w3-bar-item w3-button w3-padding">Enquiries</a>
  
  <a href="statistics.jsp" target="admini" class="w3-bar-item w3-button w3-padding">Statistics</a>   
<a href="adminsearchtest.jsp" target="admini" class="w3-bar-item w3-button w3-padding">Test Report</a>
<a href="adminfeesbatch.jsp" target="admini" class="w3-bar-item w3-button w3-padding">Fees Report</a>

</nav>

<!-- Top menu on small screens -->
<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide">ADMIN PANEL</div>
  
  
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="position:absolute;right:0;width:80%;">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>
  
  <!-- Top header -->
<div class="w3-container" style="background-color:  #838060; color: white">
<div class="col-sm-6">
  <h1>Admin Section</h1>
  </div>
  <form action="Logout">
<button type="submit" class="btn btn-primary btn-lg"   style="float:right;margin:2%;">Logout</button>
<a href="changepassword.jsp" target="admini" class="btn btn-primary btn-lg active" role="button" aria-pressed="true" style="float:right;margin:2%;">Change Password</a>



  </form>
  
</div>
 <iframe src="statistics.jsp"  width="100%" frameBorder="0" height="700" align="right" name="admini"></iframe>
  
    

  
  <!-- End page content -->
</div>


<script>
function myAccFunc() {
    var x = document.getElementById("demoAcc");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function myAccFunc1() {
    var x = document.getElementById("demoAcc1");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function myAccFunc2() {
    var x = document.getElementById("demoAcc2");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function myAccFunc3() {
    var x = document.getElementById("demoAcc3");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function myAccFunc4() {
    var x = document.getElementById("demoAcc4");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function myAccFunc5() {
    var x = document.getElementById("demoAcc5");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

// Click on the "Jeans" link on page load to open the accordion for demo purposes
document.getElementById("myBtn").click();
document.getElementById("myBtn1").click();
document.getElementById("myBtn1").click();

// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
</script>

</body>
</html>

