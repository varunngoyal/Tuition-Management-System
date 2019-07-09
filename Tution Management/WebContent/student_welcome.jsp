<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>    
<!DOCTYPE html>
<html lang="en">
<head>
<title>Teacher Welcome Page</title>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
    box-sizing: border-box;
}

body {
    font-family: Arial, Helvetica, sans-serif;
}

/* Style the header */
header {
    background-color: #ccc;
    padding: 30px;
    text-align: center;
    font-size: 35px;
    color: white;
    height:200px;
}

/* Create two columns/boxes that floats next to each other */
nav {
    float: left;
    width: 20%;
    height: 1000px;
    background-color:tan;
    padding: 10px 10px 10px 10px;
    font:30px;
}

/* Style the list inside the menu 
nav ul {
    list-style-type: none;
    padding: 0;
}*/

article {
    float: left;
    padding: 20px;
    width: 80%;
    background-color:white;
    height: 1000px;
}

/* Clear floats after the columns */
section:after {
    content: "";
    display: table;
    clear: both;
}

/* Style the footer */
footer {
    background-color: #777;
    padding: 10px;
    text-align: center;
    color:#ccc;
    height:100px;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens 
@media (max-width: 600px) {
    nav, article {
        width: 100%;
        height: auto;
    }
}*/
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
%>

<header>
 <h6>Welcome</h6>
</header>

<section>
  <nav>
    <ul>
      <li><a href="Retrieve.jsp">View Profile</a></li>
      <li><a href="upload.jsp">Upload image</a></li>
      <li><a href="#">view Event</a></li>
  
    </ul>
  </nav>
  
  <article>
    <h1>London</h1>
   
  </article>
</section>

<footer>
  <p><form action ="Logout">

 <button type="submit">Logout</button>
</form></p>
</footer>

</body>
</html>

    