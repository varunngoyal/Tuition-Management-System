<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%!
String c_id;
int id;
String sname;
int fees;
String sname_plus_fees;
Statement s;
ResultSet batch_details=null;
int i = 0;

String url,uname, pass;
Properties prop = new Properties();
InputStream input = null;
Connection con=null;
%>

<%
    /*c_id=request.getParameter("course_identifier"); //get country_id from index.jsp page with function country_change() through ajax and store in id variable
    id = Integer.parseInt(c_id); */  
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
if(session.getAttribute("uname")==null)
    {
  	   response.sendRedirect("login.jsp");
    }    
    
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        
        input = getClass().getClassLoader().getResourceAsStream("db.properties");
        prop.load(input);

        url = prop.getProperty("url");
        uname = prop.getProperty("user");
        pass = prop.getProperty("password");

        con = DriverManager.getConnection(url, uname, pass);
    //try{
		//Class.forName("com.mysql.jdbc.Driver");
		//con=DriverManager.getConnection("jdbc:mysql://localhost:3306/tution_management?autoReconnect=true&useSSL=false","root","123456@varun");
            
        //PreparedStatement pstmt=null ; //create statement
        s = con.createStatement();
                
        ResultSet rs = s.executeQuery("select * from subject where course_id="+request.getParameter("course_identifier")+";"); //sql select query
        //pstmt.setInt(1,id);
        //ResultSet rs=pstmt.executeQuery(); //execute query and set in resultset object rs.

        while(rs.next())
        {
            sname = rs.getString("subject_name");
            fees = rs.getInt("fees");
            sname_plus_fees = sname + " (" + fees + ") ";
            
%>        
            <option value="<%=rs.getString("subject_id")%>" id="<%=i%>">
                <%=sname_plus_fees%>
            </option>
                  
        <%
        	i++;
        }
		
        con.close(); //close connection
    }
    catch(Exception e)
    {
        out.println(e);
    }
    
    HttpSession session1 = request.getSession();
    session1.setAttribute("MySessionVariable", i);    
%>






