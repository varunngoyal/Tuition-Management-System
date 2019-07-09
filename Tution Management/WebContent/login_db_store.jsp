<%-- 
    Document   : newjsp
    Created on : 4 Sep, 2018, 4:07:33 PM
    Author     : Himanshi
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    <style>
        #error_message {
            color: red;
        }
    </style>
    </head>
    <body>
<%
    String username=request.getParameter("uname");
    String password=request.getParameter("psw");
    Connection con=null;
    
    try { 
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/tution_management?autoReconnect=true&useSSL=false","root","123456@varun");
        Statement s=con.createStatement();
        String query="SELECT * FROM login WHERE uname='" + username + "' AND pass = '"
            + password + "';";
    
        ResultSet rs = s.executeQuery(query);
        
        if(!rs.next()) {
%>
    <div id="error_message">
    User details given for <%=request.getParameter("uname")%> are not valid.<br>
    Please try again.
    </div>
    <%@include file="index.html"%>
</body></html>
<%      return ;
        }
        }
        finally {
            try {con.close();}catch(Exception e) {}
        }
%>
<h1>This is the home page <br>
    Welcome, <%=username%></h1>
    </body>
</html>
