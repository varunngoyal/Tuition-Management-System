<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<% Class.forName("com.mysql.jdbc.Driver");  %>

<html>
 <body>
   <%@ page import="java.io.*"%>
   <%@ page import="java.sql.*"%>
   <%@ page import="com.mysql.*"%>
   <%@ page import="java.util.*"%>
   <%@ page import="java.text.*"%>
   <%@ page import="javax.servlet.*"%>
   <%@ page import="javax.servlet.http.*"%>
   <%@ page import="javax.servlet.http.HttpSession"%>
   <%@ page language="java"%>
   <%@ page session="true"%>
   <%@ page import="java.sql.*"%>
   
<%!
String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%>
<% 
Blob image = null;
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
String iurl1=null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    
    input = getClass().getClassLoader().getResourceAsStream("db.properties");
    prop.load(input);

    url = prop.getProperty("url");
    uname = prop.getProperty("user");
    pass = prop.getProperty("password");

    con = DriverManager.getConnection(url, uname, pass);
    
    stmt = con.createStatement();
    rs = stmt.executeQuery("select * from contacts where contact_id = 1;");
}
catch (Exception e) {
    out.println("DB problem"); 
    return;
}

%>
      <table border=2>
     <tr><th>DISPLAYING IMAGE</th></tr>
     <tr><td>Image 2</td></tr>
     <tr>
       <td>
 <% if( rs.next())
 { %>
 
  <img  src = "data:image/png;base64,<%=Base64.getEncoder().encodeToString(rs.getBytes("photo")) %>"  style =" width : 300px; height : 300px">
  <%} 
  System.out.println(rs.getBlob("photo"));%>
       </td>
     </tr>
    </table>

 </body>
 </html>