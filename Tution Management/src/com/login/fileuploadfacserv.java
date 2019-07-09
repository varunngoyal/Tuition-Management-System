package com.login; 
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.*; 
import java.util.*;
@WebServlet("/uploadServletfac")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB

public class fileuploadfacserv extends HttpServlet {
     
	private String url,uname, pass;
	Properties prop = new Properties();
	InputStream input = null;
	Connection con=null;

    
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields
    	
    	

    	 HttpSession session = request.getSession(true);
    	 String uname1 = (String)session.getAttribute("uname");


       // String roll_no = request.getParameter("roll_no");
         
        InputStream inputStream = null; // input stream of the upload file
         
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("image");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        String message = null;  // message will be sent back to client
         
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

            ResultSet rs = st.executeQuery("Select * from  faculty_image  where faculty_id = '" + uname1 + "'");
            
            if(!rs.next()) {
 
            // constructs SQL statement
            String sql = "INSERT INTO faculty_image (faculty_id, faculty_image) values ( ' " + uname1 + "' , ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            //statement.setString(1, roll_no);
            
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(1, inputStream);
            }
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
            
                PrintWriter out = response.getWriter();

                out.println("Profile Picture sucessfully uploaded");  
            }
        }
            else {
            	
              	
  PreparedStatement preparedStmt = con.prepareStatement("update  faculty_image  set  faculty_image = ? where faculty_id = ' " + uname1 + " ' " );
  if (inputStream != null) {
      // fetches input stream of the upload file for the blob column
      preparedStmt.setBlob(1, inputStream);
      }

        
            	  
            	  int row = preparedStmt.executeUpdate();
            	  if (row > 0) {
            	      PrintWriter out = response.getWriter();

            	       out.println(" Profile Picture Sucessfully updated");   
            	  }
            	
            }
            
        }
        
        catch (Exception e)
        {
        System.err.println("Got an exception! ");
        System.err.println(e.getMessage());}
        finally {
        	 if (con != null) {
                 
                 try {
                     con.close();
                 } catch (SQLException ex) {
                     ex.printStackTrace();
                 }
            }
            // sets the message in request scope
         //   request.setAttribute("Message", message);
             
            // forwards to the message page
          //  getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
        }
    }
}