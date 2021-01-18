package com.ode.recomment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ode.review.ReviewVO;
  
public class reCommentDAO {

	private Connection con; 
	private PreparedStatement pstmt;
	private DataSource ds;
	private ResultSet rs;
	String sql; 
	
	private Connection getConnection() {
		
		try {
			Context init = new InitialContext();
			DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/odetour");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}	
		return con;
	}
		
	public void closeDB() {
		try {
			if(rs != null) rs.close(); 
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public List<reCommentVO> allComment(int parentNum, int commentRealPage) {
		List<reCommentVO> recommentList = new ArrayList<reCommentVO>();
		if(commentRealPage != 0){
			commentRealPage =(commentRealPage -1)*5;
		}
		
		try {
			con = getConnection();
			sql = "select * from reviewcomment where parentNum=? order by idx desc" ;
			pstmt=con.prepareStatement(sql); 
			pstmt.setInt(1, parentNum);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				reCommentVO recommentVO = new reCommentVO(); 
				recommentVO.setIdx((rs.getInt("idx")));
				recommentVO.setContent((rs.getString("content")));
				recommentVO.setWriter((rs.getString("writer")));
				recommentVO.setEmail(rs.getString("email"));
				recommentVO.setWriteDate((rs.getString("writeDate")));
				recommentList.add(recommentVO);
			}

		} catch (Exception e) {
			
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return recommentList;

	}

	public void insertComment(reCommentVO recommentVO) {
		int idx = getNewCommentIdx();
		
		
		try {
			con=getConnection();
			int parentNum = recommentVO.getParentNum();
			String email = recommentVO.getEmail();
			String writer = recommentVO.getWriter(); 
			String content = recommentVO.getContent(); 
			String writeDate = recommentVO.getWriteDate(); 
			
			sql ="insert into reviewcomment (parentNum, email, writer, content, writeDate)"
					+ "values(?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, parentNum);
			pstmt.setString(2, email);
			pstmt.setString(3, writer);
			pstmt.setString(4, content);
			pstmt.setString(5, writeDate);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}

	public int updateComment(int idx , String content) {
		try {
			con=getConnection();
			sql= "update reviewcomment set content=? where idx = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return 0;
	}
	
	public int deleteComment(int idx){
		try {
			con = getConnection();
			sql="delete from reviewcomment where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return 0;
	}
	
	private int getNewCommentIdx(){
		
		try {
			con=getConnection();
			sql = "select max(idx) from reviewcomment";
			pstmt=con.prepareStatement(sql); 
			rs=pstmt.executeQuery();
			if(rs.next()){
				return(rs.getInt(1)+1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return 0;
		
	}

	public int getAllCommentSize(int parentNum) {
		int totalList = 0; 
		
		try {
			con=getConnection();
			sql = "select count(idx) from reviewcomment where parentNum=? ";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, parentNum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalList = rs.getInt(1);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return totalList;
	}

	@SuppressWarnings("unchecked")
	public JSONArray commentListPaging(int parentNum, int commentPage) {
		JSONArray commentList = new JSONArray();
		int commentStartNum = commentPage * 5;
		
		try {
			
			con = getConnection();
			sql = "select * from reviewcomment where parentNum=? order by idx desc limit ?,5" ;
			pstmt=con.prepareStatement(sql); 
			pstmt.setInt(1, parentNum);
			pstmt.setInt(2, commentStartNum);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				JSONObject recommentVO = new JSONObject(); 
				recommentVO.put("idx",rs.getInt("idx"));
				recommentVO.put("content",rs.getString("content"));
				recommentVO.put("writer",rs.getString("writer"));
				recommentVO.put("email",rs.getString("email"));
				recommentVO.put("writeDate",rs.getString("writeDate"));
				commentList.add(recommentVO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return commentList;
	}

	public List<Integer> getCommentSize(List<ReviewVO> reviewList) {
			
			List<Integer> commentSizeList = new ArrayList<Integer>();
			con=getConnection();
		try {
			for(ReviewVO bean : reviewList){
				int idx = bean.getIdx();
				sql = "select count(*) from reviewcomment where parentnum = ?";
				pstmt =con.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				if(rs.next()){
					commentSizeList.add(rs.getInt(1));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return commentSizeList;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
