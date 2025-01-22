package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String userPwd;
	private String userName;
	private String userEmail;
	private String userBirthday;
	private String userStatus;
	private String regDate;
	
	public String getUserId() {return userId;}
	public void setUserId(String userId) {this.userId = userId;}
	public String getUserPwd() {return userPwd;}
	public void setUserPwd(String userPwd) {this.userPwd = userPwd;}
	public String getUserName() {return userName;}
	public void setUserName(String userName) {this.userName = userName;}
	public String getUserEmail() {return userEmail;}
	public void setUserEmail(String userEmail) {this.userEmail = userEmail;}
	public String getUserBirthday() {return userBirthday;}
	public void setUserBirthday(String userBirthday) {this.userBirthday = userBirthday;}
	public String getUserStatus() {return userStatus;}
	public void setUserStatus(String userStatus) {this.userStatus = userStatus;}
	public String getRegDate() {return regDate;}
	public void setRegDate(String regDate) {this.regDate = regDate;}
	
	public User() {
		setUserId("");
		setUserPwd("");
		setUserName("");
		setUserEmail("");
		setUserBirthday("");
		setUserStatus("");
		setRegDate("");
	}
}
