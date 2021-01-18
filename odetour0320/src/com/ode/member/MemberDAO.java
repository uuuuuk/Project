package com.ode.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// [ �޼��� ������ ���� ]
// getConnection() => DB���� �޼��� 
// closeDB() => �ڿ����� �޼���

public class MemberDAO {
	
	private Connection con;
	private DataSource ds;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	//======================== getConnection() ========================
	private Connection getConnection() throws Exception {
		
		Context init = new InitialContext(); 
		
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/odetour");
		
		con = ds.getConnection();
		
		return con;
	}
	//======================== getConnection() ========================
	
	//=========================== closeDB() ===========================
	public void closeDB() {
		try {
			if(rs != null) rs.close(); 
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//=========================== closeDB() ===========================
	
	//========================= registerMember(memberVO) =========================
	//=> ȸ���� �߰��ϴ� �޼���
	public int registerMember(String name, String pwd1, String email, String birth, String tel) {
		
		try {
			
			con = getConnection();
			
			sql = "insert into member(name,pwd,email,domain,birth_year,birth_month,birth_day,point,tel) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			
			int domainCheck = email.indexOf('@') + 1;
			String domain = email.charAt(domainCheck) + "";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, pwd1);
			pstmt.setString(3, email);
			pstmt.setString(4, domain);
			pstmt.setString(5, birth.substring(0,4));
			pstmt.setString(6, birth.substring(5,7));
			pstmt.setString(7, birth.substring(8));
			pstmt.setInt(8, 0);
			pstmt.setString(9, "82" + tel);
			
			return pstmt.executeUpdate(); // 1�� ȸ���߰� => 1��ȯ(���񽺷�)
			
		} catch (Exception e) {
			System.out.println("MemberDAO registerMember Method Error : "+e);
		} finally {
			closeDB();
		}
		
		return -1; // ���� 
	}
	//========================= registerMember(memberVO) =========================

	//========================= getEmailDuplChk(totalEmail) ======================
	public int getEmailDuplChk(String totalEmail) {
		try{
			con = getConnection();
			sql = "select * from member where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, totalEmail);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				return 1;
			}
		}
		catch (Exception e){
			System.out.println("MemberDAO getEmailDuplChk Method Error : "+ e);
			e.printStackTrace();
		}
		finally{
			closeDB();
		}
		return 0;
	}
	//========================= getEmailDuplChk(totalEmail) ======================

	//========================= memberInfo(name, email) ==========================
	public MemberVO memberInfo(String name, String email) {
		MemberVO memberVO = null;
		try{
			con = getConnection();
			sql = "select * from member where name = ? and email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				memberVO = new MemberVO(rs.getString("name"),
										"password",
										rs.getString("email"),
										rs.getString("birth_year"),
										rs.getString("birth_month"),
										rs.getString("birth_day"),
										rs.getInt("point"),
										rs.getString("tel"))
										;
			}
			
		}
		catch (Exception e){
			
		}
		finally{
			closeDB();
		}
		return memberVO;
	}
	//========================= memberInfo(name, email) ==========================
	
	//========================= memberLoginChk(email,passwd) ======================
	public Map<String,Object> memberLoginChk(String email, String passwd) {
		Map<String,Object> loginStatMap = new HashMap<String,Object>();
		Map<String,String> namedomainMap;
		int loginResult = memberLogin(email,passwd);
		//loginResult == 1 �� ��� email�� �´� name�� ������ Map��  ����
		//loginResult == 1 �ƴ� ��� Map�� ���� loginResult ����
		if(loginResult == 1){
			namedomainMap = getMemberNameDomain(email);
			if(namedomainMap.size() > 0){
				loginStatMap.put("namedomainMap", namedomainMap);
				loginStatMap.put("loginResult", loginResult);
			}
		}
		else{
			loginStatMap.put("loginResult", loginResult);
		}
		
		return loginStatMap;
	}
	private int memberLogin(String email , String passwd){
		try{
			con = getConnection();
			sql = "select * from member where email = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return 1;
			}
		}
		catch (Exception e){
			System.out.println("MemberDAO memberLoginChk Method Error : " + e);
		}
		finally{
			closeDB();
		}		
		return 0;
	}
	private Map<String,String> getMemberNameDomain(String email){
		Map<String,String> namedomainMap = new HashMap<String,String>();
		String name = "";
		String domain = "";
		try{
			con = getConnection();
			sql = "select name,domain from member where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);

			rs = pstmt.executeQuery();
			if(rs.next()){
				name = rs.getString("name");
				domain = rs.getString("domain");
				namedomainMap.put("name", name);
				namedomainMap.put("domain", domain);
			}
		}
		catch (Exception e){
			System.out.println("MemberDAO getMemberName Method Error : " + e);
		}
		finally{
			closeDB();
		}
		return namedomainMap;
	}
	//========================= memberLoginChk(email,passwd) ======================

	//========================= memberModify(email,pwd) ============================
	public int memberModify(String email, String pwd) {
		try{
			sql = "update member set pwd = ? where email = ?";
			con = getConnection();
			pstmt.setString(1, pwd);
			pstmt.setString(2, email);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("MemberDAO memberModify Method Error : " + e);
		}
		finally{
			closeDB();
		}
		return 0;
	}
	//========================= memberModify(email,pwd) ============================

	//=========================== memberDelete(email) ==============================
	public int memberDelete(String email) {
		try{
			con = getConnection();
			
			sql = "delete from reviewcomment where email =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
			
			sql = "delete from review where email =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
			
			sql = "delete from qna where email =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
			
			sql = "delete from member where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("MemberDAO memberDelete Method Error : " + e);
			e.printStackTrace();
		}
		finally{
			closeDB();
		}
		return 0;
	}
	//=========================== memberDelete(email) ==============================
	
	//========================= adminAuthMemberDelete(tel) =========================
	public int adminAuthMemberDelete(String tel) {
		String email = null ;
		try{
			con = getConnection();
			sql = "select email from member where tel =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tel);
			rs = pstmt.executeQuery();
			if(rs.next()){
				email = rs.getString("email");
				
				sql = "delete from reviewcomment where email =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.executeUpdate();
				
				sql = "delete from review where email =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.executeUpdate();
				
				sql = "delete from qna where email =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.executeUpdate();
				
				sql = "delete from member where email = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				
				return pstmt.executeUpdate();
			}
			else{
				System.out.println("MemberDAO adminAuthMemberDelete Method [email] Search Error");
			}
		}
		catch(Exception e){
			System.out.println("MemberDAO adminAuthMemberDelete Method Error : " + e);
		}
		finally{
			closeDB();
		}
		return 0;
	}
	//========================= adminAuthMemberDelete(tel) =========================

	//============================ memberSearch(name) ============================
	public ArrayList<MemberVO> memberSearch(String name) {
		ArrayList<MemberVO> memberList = new ArrayList<MemberVO>();
		
		try {
			String admin = "admin";
			con = getConnection();
			
			sql = "select * from member where name like ? and name = ? = 0 order by name desc"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%" + name + "%");
			pstmt.setString(2, admin);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO memberVO = new MemberVO();
				
				memberVO.setName(rs.getString("name"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setDomain(rs.getString("domain"));
				memberVO.setBirth_year(rs.getString("birth_year"));
				memberVO.setBirth_month(rs.getString("birth_month"));
				memberVO.setBirth_day(rs.getString("birth_day"));
				memberVO.setPoint(rs.getInt("point"));
				memberVO.setTel(rs.getString("tel"));
				memberList.add(memberVO);
			}
			
		} catch (Exception e) {
			System.out.println("memberSearch(String name) �޼��� ����"+e);
		} finally {
			closeDB();
		}
		return memberList;
	}
	//============================ memberSearch(name) ============================

	//============================ memberRewritePwd(rewritePwd) ============================
/*	UPDATE ���̺��̸�
	SET �ʵ��̸�1=�����Ͱ�1, �ʵ��̸�2=�����Ͱ�2, ...
	WHERE �ʵ��̸�=�����Ͱ�*/
	public int memberRewritePwd(String email ,String rewritePwd) {
		try{
			sql = "update member set pwd = ? where email = ?";
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rewritePwd);
			pstmt.setString(2, email);
			
			return pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("MemberDAO memberRewritePwd Method Error : " + e);
		}
		finally{
			closeDB();
		}
		return 0;
	}
	//============================ memberRewritePwd(rewritePwd) ============================


	
	
	
	
}//MemberDAO��
