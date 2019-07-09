<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="gen_validatorv4.js" type="text/javascript"></script>
  
   <link rel="stylesheet" href="style.css">
<style>
   body {font-family: Arial, Helvetica, sans-serif;
   .container{
    margin:200px 100px 100px 100px;
}
  </style>

</head>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Success Class</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="../home.html">Home</a></li>
        <li><a href="about.html">About Us</a></li>
       <li><a href="course.html">Courses</a></li>
        <li><a href="contact.jsp">Contact Us</a></li>
      </ul>
    <!--   <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>-->
    </div>
  </div>
</nav>


<body style="background-color: #ebedef ;">

<br>


<div class="container">
  <div class="col-sm-offset-2 col-sm-10">
   <div class="panel panel-default">
                <div class="panel-heading">
                  <strong><center>Enquiry Form</center></strong>
                 </div>
  
  <div class="panel-body">
  <form class="form-horizontal"  id="myform" method="post" action="enquiry_process.jsp" >
    <div class="form-group">
      <label class="control-label col-sm-2" for="first_name">FIRST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control" id="first_name" placeholder="Enter name" name="first_name" required>
      </div>
       <label class="control-label col-sm-2" for="last_name">LAST NAME:</label>
      <div class="col-sm-4">
       <input type="text" class="form-control" id="last_name" placeholder="Enter name" name="last_name" required>
      </div>
    </div>
      <div class="form-group">
      <label class="control-label col-sm-2" for="email"> EMAIL:</label>
      <div class="col-sm-10">          
        <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" required>
      </div>
      </div>
      <div class="form-group">
      <label class="control-label col-sm-2" for="phone">MOBILE NO:</label>
      <div class="col-sm-10">          
     
        <input type="text" class= "form-control"name="phone" id="phone"
         pattern="[1-9]{1}[0-9]{9}" title="Enter 10 digit mobile number" placeholder="Mobile number" required>
        
      </div>
       </div>

    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
         <button type="submit" class="btn btn-default" value="submit">Enquire Now</button>
      </div>
    </div>

  </form>
  
  <script  type="text/javascript">
 var frmvalidator = new Validator("myform");
 frmvalidator.addValidation("first_name","req","Please enter your First Name");
 frmvalidator.addValidation("first_name","maxlen=20",
        "Max length for FirstName is 20");
 
 frmvalidator.addValidation("last_name","req");
 frmvalidator.addValidation("last_name","maxlen=20");
 
 frmvalidator.addValidation("email","maxlen=50");
 frmvalidator.addValidation("email","req");
 frmvalidator.addValidation("email","email");
 
 
 

</script>
  
</div>
</div>
</div>
<br>
<br>
<br>
</div>
<footer class="site-footer">
    <div class="container">
     <div class="row">
     <h4>Information</h4>
     <address>
     Tution Management<br>
     system.
     </address>
     <div class="col-md-2">
    
     </div>
        <div class="bottom-footer">
          <div class="col-md-5">@copyright 2018
           </div>
           <div class="col-md-7">
              <ul class="footer-nav">
                <li><a href="home.html">Home</a></li>
                <li><a href="about.html">About Us</a></li>
                <li><a href="contact.jsp">Contact Us</a></li> 
              </ul>

          </div>
     </div>
    </div>
</footer>

</body>

</html>

