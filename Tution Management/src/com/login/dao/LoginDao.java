
package com.login.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.*; 
import java.util.*;
public class LoginDao {

	String sql ="select * from login where uname =? and pass =?";

	
	
           
	      public boolean check(String uname1 ,String pass1)
	      
	      {
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
	    	
	    	PreparedStatement st= con.prepareStatement(sql);
	    	
	    	st.setString(1, uname1);
	    	st.setString(2, pass1);
	    	
	     ResultSet rs = st.executeQuery();
	     if (rs.next())
	     {
	    	 return true;
	     }
}
	    	 catch (Exception e)
	    	 {
	    		 e.printStackTrace();
	    	 }
	    	  return false;
	    	  
	      }
}
