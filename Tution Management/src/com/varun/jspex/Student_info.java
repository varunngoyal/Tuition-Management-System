package com.varun.jspex;

public class Student_info  {

	private String firstname, lastname, address, college;
    private String roll_no, dob, phone_no, email;
    private String gender, course;
    private String admitted_date, photo, batch, password, repassword;
    private String parent_email, parent_mobile, parent_name, parent_id; 
    private String parent_pass,parent_repass;
    private String x_percentage,school_name;
    
    public void setFirst_name(String s) {firstname = s;}
    public void setLast_name(String s) {lastname = s;}
    public void setAddress(String s) {address = s;}
    public void setCollege(String s) {college = s;}
    public void setRoll_no(String s) {roll_no = s;}
    public void setDob(String s) { dob = s; }
    public void setPhone(String s) {phone_no = s;}
    public void setEmail(String s) {email = s;}
    public void setGender(String s) {gender = s;}
    public void setCourse(String s) {course = s;}
    public void setAdmission_date(String s) {admitted_date = s;}
    //public void setPic(String s) {photo = s;}
    public void setBatch(String s) {batch = s;}
    public void setPass(String s) { password = s; }
    public void setRepass(String s) {repassword = s;}
    public void setPid(String s) { parent_id = s; }
    public void setPname(String s) {parent_name = s;}
    public void setPemail(String s) {parent_email = s;}
    public void setPphone(String s) {parent_mobile = s;}
    public void setParent_pass(String s) { parent_pass = s; }
    public void setParent_repass(String s) { parent_repass = s; } 
    public void setPercentage(String s) {x_percentage = s; }
    public void setSchool_name(String s) {school_name = s; }
    
    public String getFirst_name( ) {return firstname;}
    public String getLast_name() {return lastname;}
    public String getAddress() {return address;}
    public String getCollege() {return college;}
    public String getRoll_no() {return roll_no;}
    public String getDob() {return dob;}   
    public String getPhone() {return phone_no;}
    public String getEmail() {return email;}
    public String getGender() {return gender;}
    public String getCourse( ) {return course;}
    public String getAdmission_date() {return admitted_date;}
    //public String getPic() {return photo;}
    public String getBatch() {return batch;}
    public String getPass() {return password;}
    public String getRepass() {return repassword;}
    public String getPid() { return parent_id; }
    public String getPname() {return parent_name; }
    public String getPemail() {return parent_email; }
    public String getPphone() {return parent_mobile; }
    public String getParent_pass( ) { return parent_pass; }
    public String getParent_repass( ) { return parent_repass; }
    public String getPercentage( ) { return x_percentage; }
    public String getSchool_name( ) { return school_name; }    
    
    public String insertStudent() {
    	String query = "INSERT INTO student"+
    	"(roll_no, first_name, last_name, email, phone, DOB, gender, address, college_name, parent_id) VALUES ("+
    	roll_no+",'"+firstname+"','"+lastname+"','"+email+"', "+phone_no+",'"+dob+"','"+
    	gender+"','"+address+"','"+college+"',"+parent_id+ " ); ";
    	return query;
    }
    
    public String insertStudentLogin() {
    	String query = "INSERT INTO login VALUES ('"+
    	roll_no+"','"+password+"'); ";		
    	return query;
    }
    
    public String updateParentLogin() {
    	String query = "UPDATE login "+
        "SET pass = '"+parent_pass+"' WHERE uname = "+parent_id;
    	return query;
    }
    
    public String insertParentLoginPartial() {
    	String query = "INSERT INTO login(uname) VALUES ( "+
        parent_id+" );";
    	return query;
    }
    
    public String insertParent() {
    	String query = "INSERT INTO parent VALUES ( "+
    	parent_id+" ,'"+parent_name+"','"+parent_email+"', "+parent_mobile+" ); ";
    	return query;
    }
    
    public String selectCourse() {
    	return "SELECT * FROM course;";
    }

    public String selectSubject(int course_id) {
    	String query = "SELECT * FROM subject"+
    	"WHERE course_id = '"+course_id+"';";
    	return query;
    }
    public String updateStudent(int roll_no,int batch_id) {
    	String update=null;
    	update = "UPDATE student "+
    			"SET course_id="+course+","+
    			" batch_id= "+batch_id+", "+
    			" tenth_perc="+x_percentage+","+
    			" school_name= '"+school_name+
    			"' WHERE roll_no="+roll_no+";";
    	return update;
    }
    
    public String insertSubjectStudents(String[] subjects,int student_id) {
    	String update = "INSERT INTO student_subject VALUES ";
    	String to_append = "";
    	int i;
    	for(i=0;i<(subjects.length)-1;i++) {
    		to_append += "("+student_id+","+subjects[i]+"),";
    	}
    	to_append += "("+student_id+","+subjects[i]+");";
    	update += to_append;
    	return update;
    			
    }
    
    public String getbatch_id() {
    	String query = "SELECT * FROM batch WHERE "+
    			" batch_name = '"+batch + "' AND course_id = "+course+" ORDER BY year desc LIMIT 1;";
    	return query;
    }
}
