package com.login; 
import java.io.IOException;
import java.io.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.*; 
import java.io.*;
import java.sql.*;

@WebServlet("/addmarksservlet.java")


public class addmarksservlet extends HttpServlet {
    
    String url,uname, pass;
    Properties prop = new Properties();
    InputStream input = null;
    int  max_score;
   
    
    protected void doPost(HttpServletRequest request,

    		HttpServletResponse response) throws ServletException, IOException {
        
         HttpSession session = request.getSession(true);
    	 String uname1 = (String)session.getAttribute("uname");


        String student_id = request.getParameter("student_id");
        System.out.println(student_id);
        String test_id =request.getParameter("test_id");
        System.out.println(test_id);
        String score =request.getParameter("score");
        System.out.println(score);
        
        Connection con = null; // connection to the database
       

		
         
        try {
            // connects to the database
            Class.forName("com.mysql.jdbc.Driver");
            
            input = getClass().getClassLoader().getResourceAsStream("db.properties");
            prop.load(input);

            url = prop.getProperty("url");
            uname = prop.getProperty("user");
            pass = prop.getProperty("password");

            con = DriverManager.getConnection(url, uname, pass);
 
            Statement st = con.createStatement();
            
            
            ResultSet resultset = st.executeQuery("select * from test where test_id = ' " + test_id + " ' ");
            
            if( resultset.next())
            {
            	max_score = resultset.getInt("max_score");
            }
            	
            int number= Integer.parseInt(score);

            if( number <= max_score )
            {
            ResultSet rs = st.executeQuery("Select * from  test_results where test_id = '" + test_id + "'");
                     
            if(!rs.next()) {
            	
            
            String sql = "insert into test_results values (?, ?, ?);";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1,test_id);  
            statement.setString(2,student_id);  
            statement.setString(3,score);  
            
           statement.execute();
      
        int row = statement.executeUpdate();
        if (row > 0) {
            PrintWriter out = response.getWriter();

             out.println("Marks of student uploaded");   
        }
            }
       
        else {    

            	
  PreparedStatement preparedStmt = con.prepareStatement("update  test_results  set  score = ? where student_id = ' " + student_id + "' and  test_id = ' " + test_id +  " ' " );
  preparedStmt.setString(1, score);
  preparedStmt.executeUpdate();
  
  int row = preparedStmt.executeUpdate();
  if (row > 0) {
      PrintWriter out = response.getWriter();

       out.println("Marks of student updated");   
  }

            	
            }
            
    
        }
        else {
        	
        	  PrintWriter out = response.getWriter();

              out.println("score obtained is greater than maximum score please re-enter the correct marks"); 
              
              //request.getRequestDispatcher("addscore.jsp").forward(request, response);


        }
         
        }   
        
        catch (Exception e)
        {
        System.err.println("Got an exception! ");
        System.err.println(e.getMessage());
      
    } finally {
        if (con != null) {
           
            try {
                con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        // sets the message in request scope
      //  request.setAttribute("Message", message);
         
        // forwards to the message page
    //    getServletContext().getRequestDispatcher("/message1.jsp").forward(request, response);
    }
}
}