package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;




//DAO
//DB에 관련한 모든 작업 하는 클래스 
public class BoardDAO {
		
	Connection con = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;		
	String sql = "";	
	
	
	//jspbeginner데이터베이스와 연결을 맺는 메소드
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		//커넥션풀 얻기
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//커넥션풀로 부터 커넥션객체(DB와 미리 연결 되어 있는 접속을 알리는 객체) 빌려오기
		con = ds.getConnection();
		
		return con;
	} // getConnection메소드 닫는부분
	
	
	
	
	
	/*
	 
	 답변 달기 변수 설명
	 re_ref -> 부모글과 그로부터 파생된 자식(답변) 글들이 같은 값을 가지기 위한 변수의값
	 re_seq -> 같은 그룹 글들 내에서의 순서
	 re_lev -> 같은 그룹내에서의 깊이(들여쓰기 정도 레벨)
	 
	 
	 답변달기 규칙 설명
	 순서1) re_ref값은 부모글(주글)의 그룹번호(re_ref)를 사용해야함
	 순서2) re_seq 값은 부모글의 re_seq에서 +1 증가 한 값을 사용 해야함.
	 순서3) re_lev 값은 부모글의 re_lev에서 .. +1 증가한 값을 사용 해야함.
	 
	 */
	
	
	 // 답변글 추가 메소드
	public void reInsertBoard(BoardBean bBean){
		
		int num = 0;
		
		try {
			// DB연결
			con = getConnection();
			// 추가할 답변글의 글번호 구하기
			// -> 기존에 저장되어 있는 글중 최신글번호 검색해오기
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// 검색한 최신글번호가 존재 하면
			if(rs.next()){
				// 추가할 답변글의 글번호 = 검색한 최신글번호 + 1
				num = rs.getInt(1) + 1;
				
			}else{
				num = 1;
			}
			// re_seq 답글순서 재배치
			// 부모글 그룹과 같은 그룹이면서.. 부모글의 seq값보다 큰 답변글들은?
			// seq값을 1증가 시킨다.
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref()); // 부모글의 그룹번호
			pstmt.setInt(2, bBean.getRe_seq()); // 부모글의 글 입력 순서
			pstmt.executeUpdate();
			
			// 답변글 달기
			// insert								now()함수 => 현재날짜를 반환(sysdate)랑 같음
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setString(6, bBean.getFile());
			pstmt.setInt(7, bBean.getRe_ref()); // 부모글 그룹번호 re_ref값을 사용한다.
			pstmt.setInt(8, bBean.getRe_lev() + 1); // 부모글의 re_lev에 +1을 하여 들여쓰기 값을 사용한다.
			pstmt.setInt(9, bBean.getRe_seq() + 1);
			pstmt.setInt(10, 0); // 답변글의 조회수
			pstmt.setString(11, bBean.getIp()); // 답변글을 작성하는 사람의 IP주소
			
			
			// 답변 INSERT
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
		System.out.println("reInsertBoard 메소드 오류: " + e);
			
		
		}finally{
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	
	}
	
	
	
	
	// 수정할 글정보(BoardBean)객체를 매개변수로 전달 받아.. DB에 존재하는 비밀번호와
	// 글수정 화면에서 입력한 비밀번호가 일치하면? 글 정보 UPDATE
	public int updateBoard(BoardBean bBean){
		int check = 0;
		
		try {
			// DB연결
			con = getConnection();
			
			// SELECT구문 -> 수정할 글번호에 해당하는 비밀번호 검색
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1; // 비교해서 같으면 1
					sql = "update board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					
					
					pstmt.executeUpdate();
					
					
					
					
				}else{
					check = 0; // 비교해서 다르면 0
				}
				
			}
			
		} catch (Exception e) {
		System.out.println("updateBoard메소드 오류: "+ e);
			
		}finally{
		
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
			
		}
		return check;
		
	}
	
	
	
	
	
	
	// 삭제할 글번호와 삭제할 글의 비밀번호를 매개변수로 전달 받아.. 글을 DELETE삭제 하는 메소드
	public int deleteBoard(int num, String passwd){
		
		int check = 0; // 삭제 성공, 삭제 실패 판단값 1또는 0 저장할 변수
		
		try{
			// DB연결
			con = getConnection();
			
			// 매개변수로 전달받은 삭제할 글 번호에 해당하는 비밀번호 검색
			sql = "select passwd from board where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//검색
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 검색한 글이 존재 하면
				
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					
					// 매개변수로 전달 받은 글번호에 해당 하는 글삭제
					sql ="delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					// DELETE 실행
					pstmt.executeUpdate();
					
				}else{ // 입력한 비밀번호가 DB에 존재 하지 않으면
					check = 0;
				}
				
			}
			
		}catch(Exception err){
			err.printStackTrace();
			
		}finally{
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		return check; // 비밀번호 일치 유무 1또는 0을 리턴
		
	}
	
	
	
	
	
	
	
	
	
	// 글번호를 매개변수로 전달받아.. 글번호에 해당하는 하나의 글 검색
	public BoardBean getBoard(int num){ // content.jsp에서 호출 한 메소드
		
		BoardBean boardBean = null;
		
		try {
			// 커넥션풀로 부터 커넥션 객체 얻기 (DB와 미리 연결을 맺은 Connection객체 얻기)
			con = getConnection();
			
			// 매개변수로 전달 받은 글번호에 해당되는 글 검색 SQL문
			sql = "select * from board where num=?";
			
			// select구문을 실행할 객체 얻기
			pstmt = con.prepareStatement(sql);
			
			// ?에 대응되는 글 번호 설정
			pstmt.setInt(1, num);
			
			// select 실행후 검색된 하나의 글정보를 ResultSet 임시저장소에 저장 하여 반환
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){ // 검색된 글이 존재 하면
				
				boardBean = new BoardBean(); // 검색한 정보를 rs에서 꺼내와서 저장할 용도
				
				// setter메소드를 활용 해서 변수에 검색한 값들을 저장
				boardBean.setContent(rs.getString("content"));
				boardBean.setDate(rs.getTimestamp("date"));
				boardBean.setFile(rs.getString("file"));
				boardBean.setIp(rs.getString("ip"));
				boardBean.setName(rs.getString("name"));
				boardBean.setNum(rs.getInt("num"));
				boardBean.setPasswd(rs.getString("passwd"));
				boardBean.setRe_lev(rs.getInt("re_lev"));
				boardBean.setRe_ref(rs.getInt("re_ref"));
				boardBean.setRe_seq(rs.getInt("re_seq"));
				boardBean.setReadcount(rs.getInt("readcount"));
				boardBean.setSubject(rs.getString("subject"));
				
				} // if끝
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		
		
		return boardBean; // BoardBean 객체 리턴
		
		
	} // 메소드 끝
	
	
	
	// 글번호를 매개변수로 전달받아.. 글번호에 해당하는 하나의 글 검색
		public BoardBean getfileBoard(int num){ // review.jsp에서 호출 한 메소드
			BoardBean boardBean = null;
			
			try {
				// 커넥션풀로 부터 커넥션 객체 얻기 (DB와 미리 연결을 맺은 Connection객체 얻기)
				con = getConnection();
				
				// 매개변수로 전달 받은 글번호에 해당되는 글 검색 SQL문
				sql = "select * from fileboard where num=?";
				
				// select구문을 실행할 객체 얻기
				pstmt = con.prepareStatement(sql);
				
				// ?에 대응되는 글 번호 설정
				pstmt.setInt(1, num);
				
				// select 실행후 검색된 하나의 글정보를 ResultSet 임시저장소에 저장 하여 반환
				rs = pstmt.executeQuery();
				
				
				if(rs.next()){ // 검색된 글이 존재 하면
					System.out.println(rs.getString("file"));
					System.out.println(rs.getInt("num"));
					System.out.println(rs.getString("content"));
					boardBean = new BoardBean(); // 검색한 정보를 rs에서 꺼내와서 저장할 용도
					
					// setter메소드를 활용 해서 변수에 검색한 값들을 저장
					boardBean.setContent(rs.getString("content"));
					boardBean.setDate(rs.getTimestamp("date"));
					boardBean.setFile(rs.getString("file"));
					boardBean.setIp(rs.getString("ip"));
					boardBean.setName(rs.getString("name"));
					boardBean.setNum(rs.getInt("num"));
					boardBean.setPasswd(rs.getString("passwd"));
					boardBean.setRe_lev(rs.getInt("re_lev"));
					boardBean.setRe_ref(rs.getInt("re_ref"));
					boardBean.setRe_seq(rs.getInt("re_seq"));
					boardBean.setReadcount(rs.getInt("readcount"));
					boardBean.setSubject(rs.getString("subject"));
					System.out.println(rs.getString("file"));
					} // if끝
			
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			
			
			return boardBean; // BoardBean 객체 리턴
			
			
		} // 메소드 끝
	
	
	
	
	
	// 글번호를 매개변수로 전달 받아.. 글번호에 해당되는 글의 조회수 1증가 시키는 메소드
	public void updateReadCount(int num){ // content.jsp에서 호출 하는 메소드
		
		try {
			// 커넥션풀로 부터 커넥션 객체 얻기 (DB와 미리 연결을 맺은 Connection객체 얻기)
			con = getConnection();
			
			sql = "update board set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
					
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {

			
			e.printStackTrace();
		}finally {
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	}
	
	
	
	
	// 글번호를 매개변수로 전달 받아.. 글번호에 해당되는 글의 조회수 1증가 시키는 메소드
		public void updatefileReadCount(int num){ // review.jsp에서 호출 하는 메소드
			
			try {
				// 커넥션풀로 부터 커넥션 객체 얻기 (DB와 미리 연결을 맺은 Connection객체 얻기)
				con = getConnection();
				
				sql = "update fileboard set readcount=readcount+1 where num=?";
				
				pstmt = con.prepareStatement(sql);
						
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				System.out.println("카운트증가");
			} catch (Exception e) {

				
				e.printStackTrace();
			}finally {
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
		}
	
	
	
	
	//각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수를 매개변수로 전달 받아.
	//SELECT검색한 결과를 ArrayList에 저장후 리턴 하는 메소드 
	public List<BoardBean> getBoradList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			//Connection객체 얻기 
			con = getConnection();
			//SELECT구문 만들기 
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			//SELECT구문 실행할 PreparedStatement실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//?값 설정
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			//SELECT구문 실행후 검색 한 결과 받기
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				//rs => BoardBean객체의 각변수에 저장
				bBean.setContent(rs.getString("content"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setFile(rs.getString("file"));
				bBean.setIp(rs.getString("ip"));
				bBean.setName(rs.getString("name"));
				bBean.setNum(rs.getInt("num"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setSubject(rs.getString("subject"));
					
				//BoardBean객체 => ArrayList배열에 추가
				boardList.add(bBean);

			}//while문			
			
		}catch(Exception err){
			System.out.println("getBoardList메소드 내부에서 오류 : " + err);
		}finally {
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardList;//ArrayList반환
	}
	
	
	//각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수를 매개변수로 전달 받아.
		//SELECT검색한 결과를 ArrayList에 저장후 리턴 하는 메소드 
		public List<BoardBean> getfileBoradList(int startRow,int pageSize){
			
			List<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try{
				//Connection객체 얻기 
				con = getConnection();
				
				//SELECT구문 만들기 
				sql = "select * from fileboard order by re_ref desc, re_seq desc limit ?,?";
				
				//SELECT구문 실행할 PreparedStatement실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//?값 설정
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);

				//SELECT구문 실행후 검색 한 결과 받기
				rs = pstmt.executeQuery();
				
				
				
				while (rs.next()) {
					System.out.println("1");
					BoardBean bBean = new BoardBean();
					//rs => BoardBean객체의 각변수에 저장
					bBean.setContent(rs.getString("content"));
					bBean.setDate(rs.getTimestamp("date"));
					bBean.setFile(rs.getString("file"));
					bBean.setIp(rs.getString("ip"));
					bBean.setName(rs.getString("name"));
					bBean.setNum(rs.getInt("num"));
					bBean.setPasswd(rs.getString("passwd"));
					bBean.setRe_lev(rs.getInt("re_lev"));
					bBean.setRe_ref(rs.getInt("re_ref"));
					bBean.setRe_seq(rs.getInt("re_seq"));
					bBean.setReadcount(rs.getInt("readcount"));
					bBean.setSubject(rs.getString("subject"));
					
						
					//BoardBean객체 => ArrayList배열에 추가
					boardList.add(bBean);
				}//while문	
				
				
			}catch(Exception err){
				System.out.println("getfileBoardList메소드 내부에서 오류 : " + err);
			}finally {
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return boardList;//ArrayList반환
		}
	
	
	
	
	
	
	//게시판에 저장되어 있는 전체 글 개수 검색 메소드
	public int getBoardCount(){
		
		int count = 0;//검색한 전체 글 갯수를 저장할 변수 
		
		try {
			//커넥션풀로 부터 커넥션 객체 얻기 (DB접속정보를 지니고 있는 Connection얻기)
			con = getConnection();
			//sql SELECT-> 전채 글개수 검색
			sql = "select count(*) from board";
			//SELECT문 실행 객체 얻기
			pstmt = con.prepareStatement(sql);
			//SELECT문 실행 후 검색한 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);//검색한 글의 개수 
			}
		
		} catch (Exception e) {
			System.out.println("getBoardCount()메소드 오류 : " + e);
		} finally {
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
	
	
	//리뷰게시판 사용
	public void setfileBoard(BoardBean bean){
		try {
			con = getConnection();
			sql = "insert into fileboard(passwd,file,subject,content,name,date,readcount) values(?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPasswd());
			pstmt.setString(2, bean.getFile());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getContent());
			pstmt.setString(5, bean.getName());
			pstmt.setInt(6, 0);
			pstmt.executeUpdate();
			//System.out.println("리뷰등록완료!");
			
		} catch (Exception e) {
			System.out.println("setfileBoard메서드 에러!"+e);
		} finally {
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	//게시판에 저장되어 있는 전체 글 개수 검색 메소드
		public int getfileBoardCount(){
			
			int count = 0;//검색한 전체 글 갯수를 저장할 변수 
			
			try {
				//커넥션풀로 부터 커넥션 객체 얻기 (DB접속정보를 지니고 있는 Connection얻기)
				con = getConnection();
				//sql SELECT-> 전채 글개수 검색
				sql = "select count(*) from fileboard";
				//SELECT문 실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//SELECT문 실행 후 검색한 결과 얻기
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//검색한 글의 개수 
				}
			
			} catch (Exception e) {
				System.out.println("getfileBoardCount()메소드 오류 : " + e);
			} finally {
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return count;
		}
	
	
	//게시판 새글 추가(주글)
	//-> writePro.jsp에서 insertBoard()메소드 호출시.. 
	//   전달한 BoardBean객체를 이용하여 insert SQL문을 만들자.
	public  void inserBoard(BoardBean bBean){		
		
		int num = 0; //추가할 글번호 저장 용도	
		try{
			//커넥션풀로 부터 커넥션 객체 얻기 (DB접속정보를 지니고 있는 Connection얻기)
			con = getConnection();
			//새글 추가시..글번호 구하기
			//-> board테이블에 저장되어 있는 가장 큰글번호 얻기
			//->글이 없을 경우 : 글번호 1 로 지정
			//->글이 있을 경우 : 최근 글번호(번호가 가장큰값) + 1 로 지정
			sql = "select max(num) from board";//가장 큰글번호 검색
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//검색한 데이터가 존재 하면?
				num = rs.getInt(1) + 1; //글이 있을 경우 최대글번호 + 1
			}else{//검색이 되지 않으면?
				num = 1; //글이 없을 경우 
			}
			//insert구문 만들기
			sql = "insert into board "
				+ "(num,name,passwd,subject,"
				+ "content,file,re_ref,re_lev,"
				+ "re_seq,readcount,date,ip)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			//insert구문을 실행할 PreparedStatement얻기 
			pstmt = con.prepareStatement(sql);
			//?대응 되는 추가할 값을 설정
			pstmt.setInt(1, num);//추가할 새글번호
			pstmt.setString(2, bBean.getName());//새글을 추가한 작성자 이름
			pstmt.setString(3, bBean.getPasswd());//추가할 새글의 비밀번호
			pstmt.setString(4, bBean.getSubject());//추가할 새글의 글제목
			pstmt.setString(5, bBean.getContent());//추가할 새글의 글내용
			pstmt.setString(6, bBean.getFile());//추가할 새글 데이터중 업로드할 파일명
			pstmt.setInt(7, num);// num 주글번호 기준 == re_ref 그룹번호
			pstmt.setInt(8, 0);//추가할 새글의 들여쓰기 정도값 re_lev
			pstmt.setInt(9, 0);//글 순서 re_seq
			pstmt.setInt(10, 0);//추가할 글의 조회수 readcount 0
			pstmt.setTimestamp(11, bBean.getDate());//글 작성 날짜
			pstmt.setString(12, bBean.getIp());//글쓴사람의 IP주소 
			
			//insert실행
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("insertBoard메소드 내부에서 오류:" + e);
		}finally {
			//자원해제
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}		
	}//insertBoard메소드 닫는 부분
	
}//BoardDAO닫는 부분






