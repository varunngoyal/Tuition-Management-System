<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%> 
    
<!DOCTYPE html>
<html lang="en">
<head>

  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

		<style >
		
		.button {
    background-color: grey;
    border: none;
    color: white;
    padding: 15px 30px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer;
}
		
		body {
			margin: 0;
			padding: 0;
			overflow: hidden;
			height: 100%; 
			max-height: 100%; 
			font-family:Sans-serif;
			line-height: 1.5em;
		}

        

		main {
			position: fixed;
			top:50px; /* Set this to the height of the header */
			bottom: 50px; /* Set this to the height of the footer */
			left: 230px; 
			right: 0;
			overflow: auto; 
			background: #fff;
		}
				
		#header {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 200px;
			overflow: hidden; /* Disables scrollbars on the header frame. To enable scrollbars, change "hidden" to "scroll" */
			background:#000000	
		}

		#footer {
			position: absolute;
			left: 0;
			bottom: 0;
			width: 100%;
			height: 10%; 
			overflow: hidden; /* Disables scrollbars on the footer frame. To enable scrollbars, change "hidden" to "scroll" */
			background:#000000	
		}
		

     
                  		
		#nav {
			position: absolute; 
			top: 50px; /* Set this to the height of the header */
			bottom: 50px; /* Set this to the height of the footer */
			left: 0; 
			width: 230px;
			overflow: auto; /* Scrollbars will appear on this frame only when there's enough content to require scrolling. To disable scrollbars, change to "hidden", or use "scroll" to enable permanent scrollbars */
			background:#f1f1f1;
                        height : 100%;					
		}

                
		
		.innertube {
			margin: 0px; /* Provides padding for the content */
		}
	

		nav ul {
                        display: block;
			list-style-type: none;
			margin: 0;
			color: #000;
                        padding: 8px 16px;
		}
		
		nav ul a {
			color: grey;
			text-decoration: none;
		}

                 nav ul a:hover:not(.active) {
                        background-color: #000;
                       color: white;
                     }
				
		/*IE6 fix*/
		* html body{
			padding: 50px 0 50px 230px; /* Set the first value to the height of the header, the third value to the height of the footer, and last value to the width of the nav */
		}
		
		* html main{ 
			height: 100%; 
			width: 100%; 
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
%>
 	
	
		<header id="header">
		        <div>
				<!--  <center><h4 style = "color:white">WELCOME TO PARENT LOGIN!!!</h4></center>-->
			<form action ="Logout">
                    <p align = "right">
                    <button class= "button" type="submit">Logout</button>
                    </form>
                     </p>
			</div>
		</header>

                     <main>
                     <div class="innertube">
                      <iframe src=" " height="800px" width="100%"  name = "iframe_a"></iframe>                     

                     </main>
	

		<nav id="nav"><!DOCTYPE html>
			<div class="innertube">
				<h3>Parent Section</h3>
				<br>
                                         <ul class="nav flex-column">
                                         <li class="nav-item">
                                         <a class="nav-link" href="parent.jsp" target ="iframe_a">View profile</a>
                                         </li>
                                         <li class="nav-item">
                                         <a class="nav-link" href="feesdetail.jsp" target ="iframe_a">Fees Detail</a>
                                         </li>
                                         <li class="nav-item">
                                        <a class="nav-link" href="childscore.jsp"  target ="iframe_a">Test Result</a>
                                         </li>
                                           <li class="nav-item">
                                        <a class="nav-link" href="changepassword.jsp"  target ="iframe_a">Reset Password</a>
                                         </li>
                                           <li class="nav-item">
                                        <a class="nav-link" href="parent_update_fees.jsp"  target ="iframe_a">Pay pending fees</a>
                                         </li>
                                        </ul>
					

				
			</div>
		</nav>	
		
		
	</body>
</html>