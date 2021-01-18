package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbcp2.PStmtKey;

// DAO
// DB�� ������ ��� �۾� �ϴ� Ŭ����
public class MemberDAO {

	
	// jspbeginner�����ͺ��̽��� ������ �δ� �޼ҵ�
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ�(DB�� �̸� ���� �Ǿ� �ִ� ������ �˸��� ��ü) ��������
		
		con = ds.getConnection();
		
		return con;
		
		
		
	}
	
	
	
	
	
	
	
	
	
	// �α��� ó����.. ����ϴ� �޼ҵ�
	// �Է¹��� id,pass���� DB�� ����Ǿ� �ִ� id,pass���� Ȯ���Ͽ� �α��� ó��
	
	public int userCheck(String id, String passwd){
		int check = -1; // 1�϶��� ���̵� ����,��й�ȣ ����
						// 0�϶��� ���̵� �°�, ��й�ȣ Ʋ��
						// -1�ϰ�쿡�� ���̵� Ʋ��
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			// 1. DB���� ��ü ��� (Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ���)
			con = getConnection();
			// 2. SQL(SESELCT)����� -> �Ű������� ���� �޴� id�� �ش��ϴ� ���ڵ� �˻�
			sql = "select * from member where id=?";
			// 3. SQL������ ��ü PreparedStatement ���
			pstmt = con.prepareStatement(sql);
			
			// 4. ?�� �����Ǵ� �� ����
			pstmt.setString(1, id);
			
			// 5. SELECT���� ������ �װ���� ResultSet�� ������ ���
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // �α��� �ϱ� ���� �Է��� id�� ���� �ϰ�..
				
				
				// �α��ν�.. �Է��� ��й�ȣ�� DB�� ����Ǿ� �ִ� �˻��� ��й�ȣ�� ������..
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; // ���̵� ����, ��й�ȣ ���� �Ǻ��� 1 ����
					
				}else{ // id�� ������ .. ��й�ȣ�� �ٸ��ٸ�..
					
					check = 0;
					
				}
				
			}else{ // id�� DB�� ���� ���� �ʴ´�.
				check = -1;
				
			}
			
			
			
			
			
			
		}catch(Exception e){
			System.out.println("userCheck�޼ҵ� ���ο��� ���� : "+ e);
		}finally {
			try { // ��� ����ó�� alt+ shift + z + y
				// �ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
			return check; //1�Ǵ� 0�Ǵ� -1�� ���� // loginPro.jsp�� ����
		
	} // userCheck �޼ҵ� �ݴ� ��ȣ
	
	
	
	
	///////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////
	//// ����������
	public MemberBean selectDB(String id){
		
		MemberBean memB = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			// 1. DB���� ��ü ��� (Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ���)
			con = getConnection();
			// 2. SQL(SESELCT)����� -> �Ű������� ���� �޴� id�� �ش��ϴ� ���ڵ� �˻�
			sql = "select * from member where id=?";
			// 3. SQL������ ��ü PreparedStatement ���
			pstmt = con.prepareStatement(sql);
			
			// 4. ?�� �����Ǵ� �� ����
			pstmt.setString(1, id);
			
			// 5. SELECT���� ������ �װ���� ResultSet�� ������ ���
			rs = pstmt.executeQuery();
				
			if(rs.next()) {
				memB = new MemberBean();
				memB.setId(rs.getString("id"));
				memB.setPasswd(rs.getString("passwd"));
				memB.setName(rs.getString("name"));
				memB.setEmail(rs.getString("email"));
				memB.setAddress(rs.getString("address")); 
				memB.setAddress1(rs.getString("address1"));
				memB.setAddress2(rs.getString("address2"));
				memB.setAddress3(rs.getString("address3"));
				memB.setAddress4(rs.getString("address4"));
				memB.setTel(rs.getString("tel"));
				memB.setMtel(rs.getString("mtel"));
				
			}
			
			
		}catch(Exception e){
			System.out.println("selectDB�޼ҵ� ���ο��� ���� : "+ e);
		}finally {
			try { // ��� ����ó�� alt+ shift + z + y
				// �ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
			return memB; //1�Ǵ� 0�Ǵ� -1�� ���� // loginPro.jsp�� ����
		
	} // selectDB �޼ҵ� �ݴ� ��ȣ
	
//////////////////////////////////////////////////
/////////////////////////////////////////////////
////����������
	
	
	
	
	
	
	
	
	// ȸ�������� ����.. ����ڰ� �Է��� id���� �Ű������� ���� �޾�..
	// DB�� ����ڰ� �Է��� id���� ���� �ϴ��� SELECT�˻� �Ͽ�..
	// ���� ����ڰ� �Է��� id�� �ش��ϴ� ȸ�� ���ڵ尡 �˻� �Ǹ�?
	// check �������� 1�� ���� �Ͽ� <--- ���̵� �ߺ� ���� ��Ÿ����,
	// ���� ����ڰ� �Է��� id�� �ش��ϴ� ȸ�� ���ڵ尡 �˻��� ���� ������?
	// check�������� 0���� �����Ͽ� <--- ���̵� �ߺ� �ƴ��� ��Ÿ����..
	// ��������� ���̵� �ߺ��̳�... �ߺ��� �ƴϳ�...�� check������ ����Ǿ� �����Ƿ�..
	// check�������� �����Ѵ�.
	
	public int idCheck(String id){
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			
		// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
		con = getConnection();
			
		// 2. SQL���� ����� (SELECT)-> �Ű������� ���޹��� �Է��� ���̵� �ش��ϴ� ���ڵ� �˻�
		sql = "select * from member where id=?";
		
		// 3. SQL���� ������ PreparedStatment��ü ����
		// ?��ȣ�� �����Ǵ� SELECT�� ���� ������ ������ ��ü SELECT������
		// PreparedStatment��ü�� ��� ��ȯ �ޱ�
		pstmt = con.prepareStatement(sql);
		
		// 4. ?��ȣ�� �����Ǵ� ���� ����
		pstmt.setString(1, id);
		
		// 5. prepareStatement ��ü�� executeQuery()�޼ҵ带 ȣ���Ͽ�..
		// �˻�!!!! �˻��� �� ����� ResultSet�� ��� ��ȯ
		rs = pstmt.executeQuery();
		
		// 6. �츮�� �Է��� id�� �ش��ϴ� ���ڵ尡 �˻��Ǹ�?(id�� ���� �ϸ�,id�� �ߺ��Ǿ��ٸ�)
		if(rs.next()){
			check = 1;
		}else{ // �Է��� id�� �ش��ϴ� ȸ�����ڵ尡 �˻� ���� ������?
				// (id�� �ߺ� ���� �ʾҴٸ�)
			check = 0;
			
		}
		
		
			
		} catch (Exception e) {
			System.out.println("idCheck()�޼ҵ忡�� ���� : "+ e);
		
		} finally {
			try { // ��� ����ó�� alt+ shift + z + y
				// �ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
			
			
			
		} // finally �ݴ°�
		
		// 7. check������ ����
		return check; // 1�Ǵ� 0�� ����
		
	} // idCheck()�޼ҵ� �ݴ� ��ȣ
	
	
	
	public void updatemember(MemberBean memberBean, String id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert������ ����� ������ ����
		String sql = "";
		ResultSet rs = null;
		
		try {
			// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
			con = getConnection();
			
			sql = "select * from member where id=?";
			
			
			// 3. SQL���� ������ PreparedStatment��ü ����
			// ?��ȣ�� �����Ǵ� insert�� ���� ������ ������ ��ü insert������ PreparedStatment��ü�� ���
			// ��ȯ �ޱ�
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?�⿡ȣ �����Ǵ� insert�� ���� ����
			pstmt.setString(1, id);
			
			
			// 5. PreparedStatment��ü�� executeQuery()�޼ҵ带 ȣ���Ͽ� �˻�!
			// �˻��� �� �����  ResultSet�� ��� ��ȯ
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()){
			
			// 2. SQL���� ����� (INSERT)
			sql = "update member set passwd=?, name=?, reg_date=?, email=?, address=?, "
					+"address1=?, address2=?, address3=?, address4=?," + "tel=?, mtel=?" + "where id=?";
			
			// 3. SQL������ ������ PreparedStatement ��ü ���
			// ?��ȣ�� �����Ǵ�  update�� ���� ������ ������ ��ü update������  PreparedStatement
			// ��ü�� ��� ��ȯ�ޱ�.
			
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?��ȣ�� �����Ǵ� insert�� ���� ����
			pstmt.setString(1, memberBean.getPasswd());
			pstmt.setString(2, memberBean.getName());
			pstmt.setTimestamp(3, memberBean.getReg_date());
			pstmt.setString(4, memberBean.getEmail());
			pstmt.setString(5, memberBean.getAddress());
			pstmt.setString(6, memberBean.getAddress1() );
			pstmt.setString(7, memberBean.getAddress2());
			pstmt.setString(8, memberBean.getAddress3());
			pstmt.setString(9, memberBean.getAddress4());
			pstmt.setString(10, memberBean.getTel());
			pstmt.setString(11, memberBean.getMtel());
			pstmt.setString(12, id);
			
			
			// 5. PreparedStatment�� ������ insert��ü ������ DB�� �����Ͽ� ����
			pstmt.executeUpdate(); //���� ��ȯ���� int��
			
			}
			
			
			
		} catch (Exception e) {
			System.out.println("updateMember�޼ҵ� ���ο��� ����: "+ e);
		
		}finally{
			// 6. �ڿ�����
			
			
			try { // ���� ���� ������ �巡�� �ؼ� alt + shift + z  y�� try����
				if(rs != null){ // ����ϰ� ������
					pstmt.close();
				}
				if(con != null){ // ����ϰ� ������
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		} // finally �ݴ� �κ�
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// joinPro.jsp���� �Ű������� ���� ���� MemberBean�� DB�� �߰� ��Ű�� �޼ҵ�
	
	public void insertMember(MemberBean memberBean){
	
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert������ ����� ������ ����
		String sql = "";
		
		try {
			// 1. DB���� (Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ� ���)
			con = getConnection();
			
			// 2. SQL���� ����� (INSERT)
			sql = "insert into member(id,passwd,name,reg_date,email,address,address1,address2,address3,address4,tel,mtel)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			// 3. SQL���� ������ PreparedStatment��ü ����
			// ?��ȣ�� �����Ǵ� insert�� ���� ������ ������ ��ü insert������ PreparedStatment��ü�� ���
			// ��ȯ �ޱ�
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?�⿡ȣ �����Ǵ� insert�� ���� ����
			pstmt.setString(1, memberBean.getId());
			pstmt.setString(2, memberBean.getPasswd());
			pstmt.setString(3, memberBean.getName());
			pstmt.setTimestamp(4, memberBean.getReg_date());
			pstmt.setString(5, memberBean.getEmail());
			pstmt.setString(6, memberBean.getAddress());
			pstmt.setString(7, memberBean.getAddress1());
			pstmt.setString(8, memberBean.getAddress2());
			pstmt.setString(9, memberBean.getAddress3());
			pstmt.setString(10, memberBean.getAddress4());
			pstmt.setString(11, memberBean.getTel());
			pstmt.setString(12, memberBean.getMtel());
			
			
			// 5. PreparedStatment�� ������ insert��ü ������ DB�� �����Ͽ� ����
			pstmt.executeUpdate(); //���� ��ȯ���� int��
			
			
			
		} catch (Exception e) {
			System.out.println("insertMember�޼ҵ� ���ο��� ����: "+ e);
		
		}finally{
			// 6. �ڿ�����
			
			
			try { // ���� ���� ������ �巡�� �ؼ� alt + shift + z  y�� try����
				if(pstmt != null){ // ����ϰ� ������
					pstmt.close();
				}
				if(con != null){ // ����ϰ� ������
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		} // finally �ݴ� �κ�
		
		
	}// insertMember �޼ҵ� �ݴ� �κ�
	
	
}// MemberDAOŬ���� �ݴ� �κ�
