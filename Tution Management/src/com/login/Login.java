package com.login;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.*;

import com.login.dao.LoginDao;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
          
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
	    Date dNow = new Date( );
	    SimpleDateFormat ft = new SimpleDateFormat ("yyyy/MM/dd");
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");

		
  	  String url,uname1, pass1;
	  Properties prop = new Properties();
	  InputStream input = null;
	  Connection con=null;
	 try { 
		 
		    Class.forName("com.mysql.jdbc.Driver");
		    
		    input = getClass().getClassLoader().getResourceAsStream("db.properties");
		    prop.load(input);

		    url = prop.getProperty("url");
		    uname1 = prop.getProperty("user");
		    pass1 = prop.getProperty("password");

		    con = DriverManager.getConnection(url, uname1, pass1);
		    Statement s=con.createStatement();
		   

	  
		
		LoginDao dao = new LoginDao();
		
		if ( dao.check(uname, pass)) {
		
			HttpSession session = request.getSession(); // reuse existing
															// session if exist
		   session.setAttribute("uname", uname); //for admin
			int i=Integer.parseInt(uname);  
			ResultSet rs = s.executeQuery("SELECT * FROM visited WHERE date = '"+ft.format(dNow)+"';");
			
			if(rs.next()) {
				s.executeUpdate("UPDATE visited SET count = count+1 WHERE date = '"+ft.format(dNow)+"';");				
			} else {
				s.executeUpdate("INSERT INTO visited VALUES ('"+ft.format(dNow)+"', 1);");	
			}
			
			if (uname.equals("111"))
			{
			response.sendRedirect("admin.jsp");
			}
			else if ((i >= 1) && (i <= 5000)) /// for student
			{
			  response.sendRedirect("finalstudentsection.jsp");
			}
			
			else if ((i >= 5001) && (i <= 10000))  // for parent
			{
			  response.sendRedirect("finalparentsection.jsp");
			}
			
			
			else if ((i >= 20001) && (i <= 20100))  // for faculty
			{
			  response.sendRedirect("finalfacultysection.jsp");
			
			}
			
			else {
				//response.sendRedirect("login.jsp");
				  response.setContentType("text/html");
				  PrintWriter out = response.getWriter();

				  out.println("<HTML>" +
				     "<body bgcolor=Red>" +
				     "Username or Password is incorrect" +
				     "</body></HTML>"); 

			} 
			
		}
		else {
			//response.sendRedirect("login.jsp");
			  response.setContentType("text/html");
			  PrintWriter out = response.getWriter();

			  out.println("<HTML>" +
			     "<body bgcolor=Red>" +
			     "Not registered username" +
			     "</body></HTML>"); 

			} // TODO Auto-generated method stub
	 	} catch (Exception e){
		 e.printStackTrace();
	 	}
	}
}
