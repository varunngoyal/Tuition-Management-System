<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login Form</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <style>
   body {font-family: Arial, Helvetica, sans-serif;
       background-color:#484848;}

  .panel{
    
   margin :  10% 0px 20px 0px;
}

   .imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
}

img.admin2{
    width: 30%;
    border-radius: 50%;
}


  </style>
</head>
<body>
<form  action = "Login" method = "post">
<div class="container" >
  <div class="col-sm-offset-2 col-sm-8">
   <div class="panel panel-default" style ="font-color:#484848">
  <div class="panel-body" style = "border: 2px solid white; background-color: #CC9999">
            <h1> <center> Login here </center> </h1>
          <div class="imgcontainer">
          <img class= "admin2"src="st1.png"  class="admin">
        </div>                                                                                            
       <div class="form-group">
      <label class="control-label col-sm-2" for="uname"><h3>Username</h3></label>
      <input type="text" class="form-control" id="uname" placeholder="Enter name" name="uname">
      </div>
       <div class="form-group">
       <label class="control-label col-sm-2" for="pass"><h3>Password</h3></label>
       <input type="password" class="form-control" id="pass" placeholder="Enter password" name="pass">
     </div>
    <div  class="col-sm-offset-5  col-sm-2 ">
    <button type="submit" class="btn btn-default">Login</button>
        </div>
      </div>
    </div>
    </div>
    </div>
  </form>


</body>
</html>
    