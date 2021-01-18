package com.ode.recomment;

public class reCommentVO {

	private int idx;
	private int parentNum;
	private String email;
	private String writer;
	private String content; 
	private String writeDate;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getParentNum() {
		return parentNum;
	}
	public void setParentNum(int parentNum) {
		this.parentNum = parentNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
}
