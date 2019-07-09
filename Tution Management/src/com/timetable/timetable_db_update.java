package com.timetable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*; 
import java.util.*;

/**
 * Servlet implementation class timetable_db_update
 */
@WebServlet("/timetable_db_update")
public class timetable_db_update extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int duration,i=0;
		String start_time, day, faculty_id, subject_id, batch_name;
		String course_id;
	  	 String url,uname, pass;
	  	 Properties prop = new Properties();
	  	 InputStream input = null;
	  	 Connection con=null;
		
 		try {
		    Class.forName("com.mysql.jdbc.Driver");
		    
		    input = getClass().getClassLoader().getResourceAsStream("db.properties");
		    prop.load(input);

		    url = prop.getProperty("url");
		    uname = prop.getProperty("user");
		    pass = prop.getProperty("password");

		    con = DriverManager.getConnection(url, uname, pass);
		    
			Statement s=con.createStatement();
			batch_name = request.getParameter("batch1");
			course_id = request.getParameter("course1");

			day = request.getParameter("day");
				duration = Integer.parseInt(request.getParameter("duration"+i));
				System.out.println(duration);
				for(int j=0;j<duration;j++) {
					start_time = request.getParameter("realtime"+i+""+j);
					subject_id = request.getParameter("subjects"+i+""+j);
					faculty_id = request.getParameter("faculty_id"+i+""+j);
					System.out.println(start_time);
					System.out.println(subject_id);
					System.out.println(faculty_id);
					System.out.println(batch_name);
					System.out.println(course_id);
					System.out.println(day);

					s.executeUpdate("DELETE FROM time_table"+
					" WHERE batch_name = '"+batch_name+
					"' AND day = '"+day+"' AND subject_id IN (SELECT subject_id FROM subject WHERE course_id = "+course_id+");");
					
					s.executeUpdate("INSERT INTO time_table VALUES('"+start_time+"','"+
					day+"',"+faculty_id+", '"+batch_name+"',"+subject_id+");");
				}
			
			//time,day,faculty_id, batch_name, subject_id
			response.sendRedirect("time_table_updated.html");
			con.close();
			
		} catch(Exception e) {
			System.out.println(e);
		}
	}

}
