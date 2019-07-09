package com.timetable;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.io.*; 
import java.util.*;

/**
 * Servlet implementation class timetable_db_store
 */
@WebServlet("/timetable_db_store")
public class timetable_db_store extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	  	 String url,uname, pass;
	  	 Properties prop = new Properties();
	  	 InputStream input = null;
	  	 Connection con=null;
		int duration;
		String start_time, day, faculty_id, subject_id, batch_name;
		String[] weekdays={"Monday","Tuesday","Wednesday","Thursday","Friday"};

 		try {
		    Class.forName("com.mysql.jdbc.Driver");
		    
		    input = getClass().getClassLoader().getResourceAsStream("db.properties");
		    prop.load(input);

		    url = prop.getProperty("url");
		    uname = prop.getProperty("user");
		    pass = prop.getProperty("password");

		    con = DriverManager.getConnection(url, uname, pass);
			Statement s=con.createStatement();
			batch_name = request.getParameter("batch");
			for(int i=0;i<5;i++) {
				day = weekdays[i];
				duration = Integer.parseInt(request.getParameter("duration"+i));
				System.out.println(duration);
				for(int j=0;j<duration;j++) {
					start_time = request.getParameter("realtime"+i+""+j);
					subject_id = request.getParameter("subjects"+i+""+j);
					faculty_id = request.getParameter("faculty_id"+i+""+j);
					System.out.println(start_time);
					System.out.println(subject_id);
					System.out.println(faculty_id);

					
					s.executeUpdate("INSERT INTO time_table values('"+start_time+"','"+day+"',"+faculty_id+",'"+batch_name+"',"+subject_id+");");
				}
			}
			//time,day,faculty_id, batch_name, subject_id
			response.sendRedirect("time_table_inserted.html");
			con.close();
			
		} catch(Exception e) {
			System.out.println(e);
		}
	}

}
