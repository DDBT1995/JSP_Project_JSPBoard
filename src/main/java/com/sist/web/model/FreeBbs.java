package com.sist.web.model;

import java.io.Serializable;

public class FreeBbs implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long freeBbsSeq;
	private String userId;
	private String freeBbsTitle;
	private String freeBbsContent;
	private int freeBbsReadCnt;
	private int freeBbsRecomCnt;
	private String freeBbsStatus;
	private String regDate;
	private String updateDate;
	private String userName;
	private long startPost;
	private long endPost;
	private boolean liked; 
	
	public boolean isLiked() {
		return liked;
	}
	public void setLiked(boolean liked) {
		this.liked = liked;
	}
	public long getFreeBbsSeq() {return freeBbsSeq;}
	public void setFreeBbsSeq(long freeBbsSeq) {this.freeBbsSeq = freeBbsSeq;}
	public String getUserId() {return userId;}
	public void setUserId(String userId) {this.userId = userId;}
	public String getFreeBbsTitle() {return freeBbsTitle;}
	public void setFreeBbsTitle(String freeBbsTitle) {this.freeBbsTitle = freeBbsTitle;}
	public String getFreeBbsContent() {return freeBbsContent;}
	public void setFreeBbsContent(String freeBbsContent) {this.freeBbsContent = freeBbsContent;}
	public int getFreeBbsReadCnt() {return freeBbsReadCnt;}
	public void setFreeBbsReadCnt(int freeBbsReadCnt) {this.freeBbsReadCnt = freeBbsReadCnt;}
	public int getFreeBbsRecomCnt() {return freeBbsRecomCnt;}
	public void setFreeBbsRecomCnt(int freeBbsRecomCnt) {this.freeBbsRecomCnt = freeBbsRecomCnt;}
	public String getFreeBbsStatus() {return freeBbsStatus;}
	public void setFreeBbsStatus(String freeBbsStatus) {this.freeBbsStatus = freeBbsStatus;}
	public String getRegDate() {return regDate;}
	public void setRegDate(String regDate) {this.regDate = regDate;}
	public String getUpdateDate() {return updateDate;}
	public void setUpdateDate(String updateDate) {this.updateDate = updateDate;}
	public String getUserName() {return userName;}
	public void setUserName(String userName) {this.userName = userName;}
	public long getStartPost() {return startPost;}
	public void setStartPost(long startPost) {this.startPost = startPost;}
	public long getEndPost() {return endPost;}
	public void setEndPost(long endPost) {this.endPost = endPost;}
	
	public FreeBbs() {
		setFreeBbsSeq(0);
		setUserId("");
		setFreeBbsTitle("");
		setFreeBbsContent("");
		setFreeBbsReadCnt(0);
		setFreeBbsRecomCnt(0);
		setFreeBbsStatus("");
		setRegDate("");
		setUpdateDate("");
	}
}
