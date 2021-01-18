package com.ode.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class qnaDAO {
	
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	
	// 데이터 베이스에 연결
	public Connection getCon(){
	
		try {
			Context initctx = new InitialContext();
			
			DataSource ds = 
					(DataSource)initctx.lookup("java:comp/env/jdbc/odetour");
		
			con = ds.getConnection(); // 커넥션 연결 해주는 메소드
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return con;
	
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray Listselect(String email){
		JSONArray qnaList = new JSONArray();
		try {
			con=getCon();
			sql="select * from qna where email = ? order by idx desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				JSONObject vo = new JSONObject();
				vo.put("qnaNum",rs.getInt("qnaNum"));
				vo.put("title",rs.getString("title"));
				vo.put("email",rs.getString("email"));
				vo.put("writer",rs.getString("writer"));
				vo.put("content",rs.getString("content"));
				vo.put("writeDate",rs.getString("writeDate"));
				vo.put("adminCheck",rs.getInt("adminCheck"));
				qnaList.add(vo);
			}
		
		} catch (Exception e) {
		e.printStackTrace();
		}finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return qnaList;
	}
	
	
	// 글추가
	public int insertDAO(qnaVO vo){
		
		int qnaNum = 0;
		int idx = 0;
		try {
			
			con=getCon();
			
			sql = "select max(qnaNum) from qna"; 
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				qnaNum = rs.getInt(1) + 1;
			}else{
				qnaNum = 1;
			}
			
			sql = "INSERT into qna (qnaNum, title, email, writer, content, writeDate, adminCheck)" 
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			
			pstmt = con.prepareStatement(sql);
				
			pstmt.setInt(1, qnaNum);
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getWriter());
			pstmt.setString(5, vo.getContent());
			pstmt.setString(6, vo.getWriteDate());
			pstmt.setInt(7, 0);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("qnaDAO insertDAO Method Error :" + e);
		}finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return 0;
	}
	
	public Map<String,Object> QnaReplyInfo(int qnaNum){
		Map<String,Object> QnaReplyMap = new HashMap<String,Object>();
		
		qnaVO qnaVO = qnainfo(qnaNum);
		QnaReplyMap.put("qnaVO", qnaVO);
		if(qnaVO.getAdminCheck() == 1){
			qnaVO replyVO = replyinfo(qnaNum);
			QnaReplyMap.put("replyVO", replyVO);
		}
		return QnaReplyMap;
	}
	
	// 글 상세
	private qnaVO qnainfo(int qnaNum){
		
		qnaVO vo = null;
		try {
			con = getCon();
			sql ="select * from qna where qnaNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()){ 
				vo = new qnaVO();
				vo.setQnaNum(rs.getInt("qnaNum"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setWriter(rs.getString("writer"));
				vo.setContent(rs.getString("content"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setAdminCheck(rs.getInt("adminCheck"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return vo;
	}
	
	private qnaVO replyinfo(int qnaNum){
		
		qnaVO vo = null;
		try {
			con = getCon();
			
			sql = "update qna set readCheck = 1 where parentNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			pstmt.executeUpdate();
			
			sql ="select * from qna where parentNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			
			rs = pstmt.executeQuery();

			if(rs.next()){ 
				vo = new qnaVO();
				vo.setQnaNum(rs.getInt("qnaNum"));
				vo.setEmail(rs.getString("email"));
				vo.setWriter(rs.getString("writer"));
				vo.setContent(rs.getString("content"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setAdminCheck(rs.getInt("adminCheck"));
				vo.setParentNum(rs.getInt("parentNum"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return vo;
	}	
	
		public void replyWrite(qnaVO vo){
		
		try {
			con=getCon();
			sql = "INSERT into qna (email, writer, content, writeDate, parentNum, readCheck)" 
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getEmail());
			pstmt.setString(2, vo.getWriter());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getWriteDate());
			pstmt.setInt(5, vo.getParentNum());
			pstmt.setInt(6, 0);
			
			pstmt.executeUpdate();
			
			sql = "UPDATE qna set adminCheck=1 where qnaNum=? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getParentNum());
			
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("getCon(); 답글작성 에러발생  :" + e);
		}finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
	}


	public void qnaDel(int qnaNum){
		
try {
			
			con=getCon();
			
			sql="delete from qna where qnaNum=? or parentNum = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			pstmt.setInt(2, qnaNum);
			pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
	}
/*	UPDATE 테이블명
	SET 수정되어야 할 컬럼명 = 수정되기를 원하는 새로운 값
	WHERE 변경 데이터 조건 컬럼 = 선택 조건 값
*/
	public int qnaRewrite(int qnaNum, String qnaTitle, String qnaContent) {
		try{
			con = getCon();
			sql = "update qna set title = ? , content = ? where qnanum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qnaTitle);
			pstmt.setString(2, qnaContent);
			pstmt.setInt(3, qnaNum);
			
			return pstmt.executeUpdate();
			
		}
		catch(Exception e){
			System.out.println("qnaDAO qnaRewrite Method Error : " + e);
		}
		finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return 0;
	}

	public ArrayList<qnaVO> adminQnaSearch(String email) {
		ArrayList<qnaVO> qnaList = new ArrayList<qnaVO>();
		try{
			con = getCon();
			sql = "select * from qna where email like ? and email = ? = 0 order by adminCheck desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + email + "%");
			pstmt.setString(2, "admin@odetour.com");
			rs = pstmt.executeQuery();
			while(rs.next()){
				qnaVO vo = new qnaVO();
				vo.setQnaNum(rs.getInt("qnaNum"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setAdminCheck(rs.getInt("adminCheck"));
				qnaList.add(vo);
			}
		}
		catch(Exception e){
			System.out.println("qnaDAO adminQnaSearch Method Error : " + e);
		}
		finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return qnaList;
	}

	@SuppressWarnings("unchecked")
	public JSONArray getInformReply(String email) {
			JSONArray qnaList = new JSONArray();
			JSONArray replyList = new JSONArray();
			JSONArray totalList = new JSONArray();
		try{
			con = getCon();
			sql = "select * from qna where email = ? order by qnaNum desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				JSONObject qnaVO = new JSONObject();
				qnaVO.put("title",rs.getString("title"));
				qnaVO.put("writeDate",rs.getString("writeDate"));
				qnaVO.put("adminCheck",rs.getInt("adminCheck"));
				qnaVO.put("parentNum",rs.getInt("parentNum"));
				qnaVO.put("qnaNum",rs.getInt("qnaNum"));
				qnaList.add(qnaVO);
			}
			for(int i = 0 ; i < qnaList.size() ; i++){
				JSONObject qnaVO = (JSONObject) qnaList.get(i);
				sql = "select * from qna where parentNum = ? and readcheck = 0";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, (int) qnaVO.get("qnaNum"));
				rs = pstmt.executeQuery();
				if(rs.next()){
					JSONObject replyVO = new JSONObject();
					replyVO.put("parentNum",rs.getInt("parentNum"));
					replyList.add(replyVO);
				}
			}
			for(int i = 0 ; i < replyList.size() ; i++){
				JSONObject replyVO = (JSONObject) replyList.get(i);
				for(int j = 0 ; j < qnaList.size() ; j++){
					JSONObject qnaVO = (JSONObject) qnaList.get(j);
					if(replyVO.get("parentNum") == qnaVO.get("qnaNum")){
						totalList.add(qnaVO);
					}
				}
			}
		}
		catch(Exception e){
			System.out.println("qnaDAO getInformReply Method Error : " + e);
			e.printStackTrace();
		}
		finally{
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return totalList;
	}
	
	//================================ getAllUnreadMessage() ================================
	public int getAllUnreadMessage(String email) {
	//=> 현재 읽지 않은 모든 메세지의 개수를 가져온다.
		try {
			con = getCon();
			sql = "select count(qnaNum) from qna where email = ? and adminCheck = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("count(qnaNum)");
			}
			return 0; // 받은 메세지가 없다는 것을 알려준다.
		} catch (Exception e) {
			System.out.println("getAllUnreadMessage() ERROR : "+e);
		} finally {
			if(rs != null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con != null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return -1; // DB ERROR
	}
	//================================ getAllUnreadMessage() ================================
	
	
	
	
	
	
	
/*	0: Array(4)
		0: {writeDate: "2020-02-27", adminCheck: 1, parentNum: 0, title: "알림 테스트", qnaNum: 2}
		1: {writeDate: "2020-02-27", adminCheck: 1, parentNum: 0, title: "알림테스트2", qnaNum: 3}
		2: {writeDate: "2020-02-27", adminCheck: 1, parentNum: 0, title: "알림 테스트3", qnaNum: 4}
		3: {writeDate: "2020-02-27", adminCheck: 0, parentNum: 0, title: "알림 테스트4", qnaNum: 5}
	length: 4
	__proto__: Array(0)
	1: Array(3)
		0: {parentNum: 2}
		1: {parentNum: 3}
		2: {parentNum: 4}
	length: 3
	*/
	
	
	
	
	
	
	
}