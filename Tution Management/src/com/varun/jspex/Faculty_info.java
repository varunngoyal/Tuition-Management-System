package com.varun.jspex;

public class Faculty_info {
	
	private String firstname, lastname, address,salary;
    private String faculty_no, dob, phone_no, email;
    private String gender,years_of_exp;
    private String photo, password;
    private String[] subjects, batch, qualification;
    
    public void setFirstname(String s) {firstname = s;}
    public void setLastname(String s) {lastname = s;}
    public void setAddress(String s) {address = s;}
    public void setFaculty_no(String s) {faculty_no = s;}
    public void setDob(String s) {dob = s;}
    public void setPhone_no(String s) {phone_no = s;}
    public void setEmail(String s) {email = s;}
    public void setGender(String s) {gender = s;}
    public void setPassword(String s) {password = s;}
    public void setSubjects(String[] s) {subjects = s;}
    public void setBatch(String[] s) {batch = s;}
    public void setQualification(String[] s) {qualification = s;}
    public void setPhoto(String s) {photo = s;}
    public void setSalary(String s) {salary = s;}
    public void setYears_of_Exp(String s) {years_of_exp = s;}
    
    public String insertFaculty() {
    	String update = "INSERT INTO faculty VALUES ("+
    		faculty_no+",'"+ firstname+"','"+ lastname+"',"+ salary+
    		",'"+ address+"','"+ dob+"','"+ gender+"',"+ phone_no+
    		","+ years_of_exp+");";
    	return update;
    }
    
    public String insertFacultySubject() {
    	String update="INSERT INTO faculty_subject VALUES ";
    	int i;
    	for(i=0;i<subjects.length-1;i++) {
    		update += "("+faculty_no+","+subjects[i]+"),";
    	}
		update += "("+faculty_no+","+subjects[i]+");";

    	return update;
    }
    
    public String insertFacultyQualification() {
    	String update="INSERT INTO faculty_qualification VALUES ";
    	int i;
    	for(i=0;i<qualification.length-1;i++) {
    		update += "("+faculty_no+",'"+qualification[i]+"'),";
    	}
    	update += "("+faculty_no+",'"+qualification[i]+"');";
    	return update;
    }
    
    public String insertFacultyBatch() {
    	String update="INSERT INTO faculty_batch VALUES ";
    	int i;
    	
    	for(i=0;i<batch.length-1;i++) {
    		update += "("+faculty_no+",'"+batch[i]+"'),";
    	}
    	update += "("+faculty_no+",'"+batch[i]+"')";
		return update;
    }
    
    public String insertFacultyLogin() {
    	String update = "INSERT INTO login VALUES ("+
    	faculty_no+",'"+password+"');";
    	return update;
    }
}
