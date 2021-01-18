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
// DB에 관련한 모든 작업 하는 클래스
public class MemberDAO {

	
	// jspbeginner데이터베이스와 연결을 맺는 메소드
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		// 커넥션풀로 부터 커넥션(DB와 미리 연결 되어 있는 접속을 알리는 객체) 빌려오기
		
		con = ds.getConnection();
		
		return con;
		
		
		
	}
	
	
	
	
	
	
	
	
	
	// 로그인 처리기.. 사용하는 메소드
	// 입력받은 id,pass값과 DB에 저장되어 있는 id,pass값을 확인하여 로그인 처리
	
	public int userCheck(String id, String passwd){
		int check = -1; // 1일때는 아이디 맞음,비밀번호 맞음
						// 0일때는 아이디 맞고, 비밀번호 틀림
						// -1일경우에는 아이디 틀림
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			// 1. DB접속 객체 얻기 (커넥션풀로 부터 커넥션 객체 얻기)
			con = getConnection();
			// 2. SQL(SESELCT)만들기 -> 매개변수로 전달 받는 id에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			// 3. SQL실행할 객체 PreparedStatement 얻기
			pstmt = con.prepareStatement(sql);
			
			// 4. ?에 대응되는 값 설정
			pstmt.setString(1, id);
			
			// 5. SELECT구문 실행후 그결과를 ResultSet에 저장후 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 로그인 하기 위해 입력한 id가 존재 하고..
				
				
				// 로그인시.. 입력한 비밀번호와 DB에 저장되어 있는 검색한 비밀번호가 같으면..
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1; // 아이디 맞음, 비밀번호 맞음 판별값 1 저장
					
				}else{ // id는 맞으나 .. 비밀번호가 다르다면..
					
					check = 0;
					
				}
				
			}else{ // id가 DB에 존재 하지 않는다.
				check = -1;
				
			}
			
			
			
			
			
			
		}catch(Exception e){
			System.out.println("userCheck메소드 내부에서 오류 : "+ e);
		}finally {
			try { // 묶어서 예외처리 alt+ shift + z + y
				// 자원해제
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
			return check; //1또는 0또는 -1을 리턴 // loginPro.jsp로 리턴
		
	} // userCheck 메소드 닫는 기호
	
	
	
	
	///////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////
	//// 마이페이지
	public MemberBean selectDB(String id){
		
		MemberBean memB = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try{
			// 1. DB접속 객체 얻기 (커넥션풀로 부터 커넥션 객체 얻기)
			con = getConnection();
			// 2. SQL(SESELCT)만들기 -> 매개변수로 전달 받는 id에 해당하는 레코드 검색
			sql = "select * from member where id=?";
			// 3. SQL실행할 객체 PreparedStatement 얻기
			pstmt = con.prepareStatement(sql);
			
			// 4. ?에 대응되는 값 설정
			pstmt.setString(1, id);
			
			// 5. SELECT구문 실행후 그결과를 ResultSet에 저장후 얻기
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
			System.out.println("selectDB메소드 내부에서 오류 : "+ e);
		}finally {
			try { // 묶어서 예외처리 alt+ shift + z + y
				// 자원해제
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
			return memB; //1또는 0또는 -1을 리턴 // loginPro.jsp로 리턴
		
	} // selectDB 메소드 닫는 기호
	
//////////////////////////////////////////////////
/////////////////////////////////////////////////
////마이페이지
	
	
	
	
	
	
	
	
	// 회원가입을 위해.. 사용자가 입력한 id값을 매개변수로 전달 받아..
	// DB에 사용자가 입력한 id값이 존재 하는지 SELECT검색 하여..
	// 만약 사용자가 입력한 id에 해당하는 회원 레코드가 검색 되면?
	// check 변수값을 1로 저장 하여 <--- 아이디 중복 됨을 나타내고,
	// 만약 사용자가 입력한 id에 해당하는 회원 레코드가 검색이 되지 않으면?
	// check변수값을 0으로 저장하여 <--- 아이디 중복 아님을 나타내고..
	// 결과적으로 아이디 중복이냐... 중복이 아니냐...는 check변수에 저장되어 있으므로..
	// check변수값을 리턴한다.
	
	public int idCheck(String id){
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			
		// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
		con = getConnection();
			
		// 2. SQL구문 만들기 (SELECT)-> 매개변수로 전달받은 입력한 아이디에 해당하는 레코드 검색
		sql = "select * from member where id=?";
		
		// 3. SQL구문 실행할 PreparedStatment객체 얻이
		// ?기호에 대응되는 SELECT할 값을 제외한 나머지 전체 SELECT문장을
		// PreparedStatment객체에 담아 반환 받기
		pstmt = con.prepareStatement(sql);
		
		// 4. ?기호에 대응되는 값을 설정
		pstmt.setString(1, id);
		
		// 5. prepareStatement 객체의 executeQuery()메소드를 호출하여..
		// 검색!!!! 검색후 그 결과를 ResultSet에 담아 반환
		rs = pstmt.executeQuery();
		
		// 6. 우리가 입력한 id에 해당하는 레코드가 검색되면?(id가 존재 하면,id가 중복되었다면)
		if(rs.next()){
			check = 1;
		}else{ // 입력한 id에 해당하는 회원레코드가 검색 되지 않으면?
				// (id가 중복 되지 않았다면)
			check = 0;
			
		}
		
		
			
		} catch (Exception e) {
			System.out.println("idCheck()메소드에서 오류 : "+ e);
		
		} finally {
			try { // 묶어서 예외처리 alt+ shift + z + y
				// 자원해제
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
			
			
			
		} // finally 닫는곳
		
		// 7. check변수값 리턴
		return check; // 1또는 0을 리턴
		
	} // idCheck()메소드 닫는 기호
	
	
	
	public void updatemember(MemberBean memberBean, String id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert구문을 만들어 저장할 변수
		String sql = "";
		ResultSet rs = null;
		
		try {
			// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
			con = getConnection();
			
			sql = "select * from member where id=?";
			
			
			// 3. SQL구문 실행할 PreparedStatment객체 얻이
			// ?기호에 대응되는 insert할 값을 제외한 나머지 전체 insert문장을 PreparedStatment객체에 담아
			// 반환 받기
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?기에호 대응되는 insert할 값을 설정
			pstmt.setString(1, id);
			
			
			// 5. PreparedStatment객체에 executeQuery()메소드를 호출하여 검색!
			// 검색후 그 결과를  ResultSet에 담아 반환
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()){
			
			// 2. SQL구문 만들기 (INSERT)
			sql = "update member set passwd=?, name=?, reg_date=?, email=?, address=?, "
					+"address1=?, address2=?, address3=?, address4=?," + "tel=?, mtel=?" + "where id=?";
			
			// 3. SQL구문을 실행할 PreparedStatement 객체 얻기
			// ?기호에 대응되는  update할 값을 제외한 나머지 전체 update문장을  PreparedStatement
			// 객체에 담아 반환받기.
			
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?기호에 대응되는 insert할 값을 설정
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
			
			
			// 5. PreparedStatment에 설정된 insert전체 문장을 DB에 전송하여 실행
			pstmt.executeUpdate(); //실제 반환값이 int형
			
			}
			
			
			
		} catch (Exception e) {
			System.out.println("updateMember메소드 내부에서 오류: "+ e);
		
		}finally{
			// 6. 자원해제
			
			
			try { // 같이 묶고 싶으면 드래그 해서 alt + shift + z  y로 try묶기
				if(rs != null){ // 사용하고 있으면
					pstmt.close();
				}
				if(con != null){ // 사용하고 있으면
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		} // finally 닫는 부분
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// joinPro.jsp에서 매개변수로 전달 받은 MemberBean을 DB에 추가 시키는 메소드
	
	public void insertMember(MemberBean memberBean){
	
		Connection con = null;
		PreparedStatement pstmt = null;
		// insert구문을 만들어 저장할 변수
		String sql = "";
		
		try {
			// 1. DB연결 (커넥션풀로부터 커넥션 얻기)
			con = getConnection();
			
			// 2. SQL구문 만들기 (INSERT)
			sql = "insert into member(id,passwd,name,reg_date,email,address,address1,address2,address3,address4,tel,mtel)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			// 3. SQL구문 실행할 PreparedStatment객체 얻이
			// ?기호에 대응되는 insert할 값을 제외한 나머지 전체 insert문장을 PreparedStatment객체에 담아
			// 반환 받기
			pstmt = con.prepareStatement(sql);
			
			
			// 4. ?기에호 대응되는 insert할 값을 설정
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
			
			
			// 5. PreparedStatment에 설정된 insert전체 문장을 DB에 전송하여 실행
			pstmt.executeUpdate(); //실제 반환값이 int형
			
			
			
		} catch (Exception e) {
			System.out.println("insertMember메소드 내부에서 오류: "+ e);
		
		}finally{
			// 6. 자원해제
			
			
			try { // 같이 묶고 싶으면 드래그 해서 alt + shift + z  y로 try묶기
				if(pstmt != null){ // 사용하고 있으면
					pstmt.close();
				}
				if(con != null){ // 사용하고 있으면
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		} // finally 닫는 부분
		
		
	}// insertMember 메소드 닫는 부분
	
	
}// MemberDAO클래스 닫는 부분
