package com.ode.member;

public class MemberVO {
	
	private String name;
	private String pwd;
	private String email;
	private String domain;
	private String birth_year;
	private String birth_month;
	private String birth_day;
	private int point;
	private String tel;
	
	
	public MemberVO() {}
	// Domain ������ ������
	public MemberVO(String name, String pwd, String email, String birth_year, String birth_month,
			String birth_day, int point, String tel) {
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.birth_year = birth_year;
		this.birth_month = birth_month;
		this.birth_day = birth_day;
		this.point = point;
		this.tel = tel;
	}
	// Domain ���� ������
	public MemberVO(String name, String pwd, String email,String domain, String birth_year, String birth_month,
			String birth_day, int point, String tel) {
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.domain = domain;
		this.birth_year = birth_year;
		this.birth_month = birth_month;
		this.birth_day = birth_day;
		this.point = point;
		this.tel = tel;
	}


	
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	
	public String getPwd() {return pwd;	}
	public void setPwd(String pwd) { this.pwd = pwd; }
	
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	
	public String getDomain() { return domain; }
	public void setDomain(String domain) { this.domain = domain; };
	
	public String getBirth_year() { return birth_year; }
	public void setBirth_year(String birth_year) { this.birth_year = birth_year; }
	
	public String getBirth_month() { return birth_month; }
	public void setBirth_month(String birth_month) { this.birth_month = birth_month; }
	
	public String getBirth_day() { return birth_day; }
	public void setBirth_day(String birth_day) { this.birth_day = birth_day; }
	
	public int getPoint() { return point; }
	public void setPoint(int point) { this.point = point; }
	
	public String getTel() { return tel; }
	public void setTel(String tel) { this.tel = tel; }
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
