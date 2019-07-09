<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset Password</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<style>
.button {
    background-color: #666666;
    border: none;
    color: white;
    padding: 10px 25px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer;
}


</style>
</head>
<body>


     <%  
    
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        
        if(session.getAttribute("uname")==null)
        {
      	   response.sendRedirect("login.jsp");
        }

      String uname = (String)session.getAttribute("uname");

         %>
        

 <div class="container" style = "margin : 10% 10% 0% 10% ">
 <div class="col-sm-offset-2 col-sm-6">
  <div class="panel panel-default">
   <div class="panel-body"  style = "background-color:#FFFFCC;">
   
  <form class="form-horizontal" method="post" action="password_reg_process.jsp" onsubmit = "return validate()">
       <div class="form-group">
      <label class="control-label col-sm-2" for="password">Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="password" placeholder="Enter password" name="pass"  required>
      </div>  
    </div>
    
      <div class="form-group">
      <label class="control-label col-sm-2" for="password">Confirm Password:</label>
      <div class="col-sm-10">          
        <input type="password" class="form-control" id="repassword" placeholder="Enter password" name="repass"  required>
      </div>
    </div> 
    
    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button class ="button" type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
         <button class= "button" type="submit" class="btn btn-default" value="next" onclick="validate()">SUBMIT</button>
      </div>
    </div>

  </form> 
  </div>
  </div>
  </div>
  </div>
  
    
  <script>
  
  function validate(){
	  
	  var password = document.getElementById("password")
	  , confirm_password = document.getElementById("repassword");
	  
	  if(password.value != repassword.value) {
      	confirm_password.setCustomValidity("Passwords Don't Match"+" "+password.value+" "+repassword.value);
      	return false;
    } else {
      	confirm_password.setCustomValidity('');
      return true;
    }
  }
  


  </script>
</body>
</html>

