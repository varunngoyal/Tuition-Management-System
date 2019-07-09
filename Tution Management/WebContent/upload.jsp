<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>upload student image</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>

</style>
</head>
<body>

  <%   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        
        if(session.getAttribute("uname")==null)
            {
          	   response.sendRedirect("login.jsp");
            }
        
  %>
          <h3><center>Upload a Profile Picture</center></h3>
  
      <div class="container" style = "margin : 10% 10% 0% 10% ">
 <div class="col-sm-offset-2 col-sm-6">
  <div class="panel panel-default">
   <div class="panel-body"  style = "background-color:#FFFFCC;">
   
  <form class="form-horizontal" method="post" action="uploadServlet" enctype="multipart/form-data">
       <div class="form-group">
      <label class="control-label col-sm-2" for="image">Profile Picture:</label>
      <div class="col-sm-10">          
        <input type="file" class="form-control" name ="image"  required>
      </div>  
    </div>
    
    
    <div class="form-group"> 
       <div class="col-sm-offset-2 col-sm-4">
         <button class ="button" type="reset" class="btn btn-default" value="reset">RESET</button>
      </div>       
      <div class="col-sm-offset-2 col-sm-4">
         <button class= "button" type="submit" class="btn btn-default" value="save" >SUBMIT</button>
      </div>
    </div>

  </form> 
  </div>
  </div>
  </div>
  </div>
  
  
    

    
    
       
</body>
</html>