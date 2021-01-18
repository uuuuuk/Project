package member;

import java.sql.Timestamp;

// VO������ �ϴ� Ŭ����
// -> ȸ�������� ���� (DB�� ȸ������ �߰�) �Է� �� ������ ���� �� �뵵
// -> DB�� ���� ȸ�� �ѻ���� ������ �˻��ؿͼ� ������ ������ �뵵�� Ŭ����

public class MemberBean {

	
	// ���� -> private, member���̺��� �÷��̸��� �ڷ����� �����ϰ�
	private String id;		// ���̵�
	private String passwd;	// ��й�ȣ
	private String name;	// �̸�
	private Timestamp reg_date; // ���Գ�¥
	private int age;		// ����
	private String gender;	// ����
	private String email;	// �̸���
	private String address;	// �ּ�
	private String address1;	// �ּ�
	private String address2;	// �ּ�
	private String address3;	// �ּ�
	private String address4;	// �ּ�
	private String tel;		// ��ȭ��ȣ
	private String mtel;	// �ڵ�����ȣ
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getAddress4() {
		return address4;
	}
	public void setAddress4(String address4) {
		this.address4 = address4;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	
	
	
	
	
	// getter, setter�޼ҵ�
	
	
	
	
	
	
	
}
