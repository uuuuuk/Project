package com.ode.qna;
 
public class qnaVO {
	private int idx; 
	private int adminCheck;
	private String title;
	private String email;
	private String writer;
	private String content;
	private String writeDate;
	private int parentNum;
	private int qnaNum;
	private int readCheck;
	public qnaVO() {}

	
	public int getReadCheck() {
		return readCheck;
	}
	public void setReadCheck(int readCheck) {
		this.readCheck = readCheck;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getAdminCheck() {
		return adminCheck;
	}
	public void setAdminCheck(int adminCheck) {
		this.adminCheck = adminCheck;
	}


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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




	public int getParentNum() {
		return parentNum;
	}




	public void setParentNum(int parentNum) {
		this.parentNum = parentNum;
	}




	public int getQnaNum() {
		return qnaNum;
	}




	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}
	
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "qnaNum:"+qnaNum;
	}
	
}
