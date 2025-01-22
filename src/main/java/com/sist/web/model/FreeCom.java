package com.sist.web.model;

import java.io.Serializable;

public class FreeCom implements Serializable
{
	private static final long serialVersionUID = 1L;
	private long freeComSeq;
	private long freeBbsSeq;
	private String userId;
	private String userName;
	private String freeComContent;
	private String freeComStatus;
	private String regDate;
	private long startPost;
	private long endPost;
	
	public FreeCom()
	{
		setFreeComSeq(0);
		setFreeBbsSeq(0);
		setUserId("");
		setUserName("");
		setFreeComContent("");
		setFreeComStatus("");
		setRegDate("");
		setStartPost(0);
		setEndPost(0);
	}
	
	
	
	public long getStartPost() {
		return startPost;
	}



	public void setStartPost(long startPost) {
		this.startPost = startPost;
	}



	public long getEndPost() {
		return endPost;
	}



	public void setEndPost(long endPost) {
		this.endPost = endPost;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public long getFreeComSeq() {
		return freeComSeq;
	}

	public void setFreeComSeq(long freeComSeq) {
		this.freeComSeq = freeComSeq;
	}

	public long getFreeBbsSeq() {
		return freeBbsSeq;
	}

	public void setFreeBbsSeq(long freeBbsSeq) {
		this.freeBbsSeq = freeBbsSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFreeComContent() {
		return freeComContent;
	}

	public void setFreeComContent(String freeComContent) {
		this.freeComContent = freeComContent;
	}

	public String getFreeComStatus() {
		return freeComStatus;
	}

	public void setFreeComStatus(String freeComStatus) {
		this.freeComStatus = freeComStatus;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
}
