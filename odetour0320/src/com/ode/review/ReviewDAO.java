package com.ode.review;

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
import javax.swing.plaf.synth.SynthSeparatorUI;

public class ReviewDAO {
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

	
	public int insertReview(ReviewVO reviewVO){	
		
		try {
			con = getConnection();
			
			sql ="insert into review(title,writer,email,content,writeDate,rating,readCount,imageFileName,domain)" 
					+ "values(?,?,?,?,?,?,?,?,?)";   
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, reviewVO.getTitle());
			pstmt.setString(2, reviewVO.getWriter());
			pstmt.setString(3, reviewVO.getEmail());
			pstmt.setString(4, reviewVO.getContent());
			pstmt.setString(5, reviewVO.getWriteDate());	
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setString(8, reviewVO.getImageFileName());
			pstmt.setString(9, reviewVO.getDomain());
			return pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			System.out.println("insertReview 메서드 에러 발생 ");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return 0;
	}
	
	public int getAllListSize(){
		int result = 0;
		try{
			con = getConnection();
			sql = " select count(idx) from review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		}
		catch(Exception e){
			System.out.println("getAllListSize Method Error : " + e);
		}
		finally{
			closeDB();
		}
		return result;
	}
	
	public List allReview(int startrow){
		List reviewList = new ArrayList(); 
		
		try {
			con = getConnection();
			sql = "select * from review order by idx desc limit ?,5";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			rs=pstmt.executeQuery(); 
			
			while(rs.next()){
			
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setIdx(rs.getInt("idx"));
				reviewVO.setTitle(rs.getString("title"));
				reviewVO.setWriter(rs.getString("writer"));
				reviewVO.setEmail(rs.getString("email"));
				reviewVO.setContent(rs.getString("content"));
				reviewVO.setWriteDate(rs.getString("writeDate"));
				reviewVO.setImageFileName(rs.getString("imagefilename"));
				reviewVO.setReadCount(rs.getInt("readCount"));
				reviewVO.setDomain(rs.getString("domain"));
				reviewList.add(reviewVO);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return reviewList;
	}
	
	public ReviewVO selectReview(int idx){
		
		ReviewVO reviewVO = new ReviewVO();
		updateReadCount(idx);
		
		try {
			con=getConnection();
			sql = "select * from review where idx=?"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs=pstmt.executeQuery();
			rs.next();
			reviewVO.setIdx(rs.getInt("idx"));
			reviewVO.setTitle(rs.getString("title"));
			reviewVO.setWriter(rs.getString("writer"));
			reviewVO.setContent(rs.getString("content"));
			reviewVO.setReadCount(rs.getInt("readcount"));			
			reviewVO.setWriteDate(rs.getString("writeDate"));
			reviewVO.setEmail(rs.getString("email"));
			reviewVO.setImageFileName(rs.getString("imageFileName"));
			reviewVO.setDomain(rs.getString("domain"));
			reviewVO.setRating(rs.getInt("rating"));
			
		} catch (Exception e) {
			System.out.println("selectReview 메서드 에러 발생!");	
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return reviewVO; 
	}

	public void updateReview(int idx, ReviewVO reviewVO) {
		
		String imageFileName = reviewVO.getImageFileName();
		System.out.println("DAO imageFileName : "+imageFileName);
		
  		try {
			con=getConnection();
			if(imageFileName == null || imageFileName.length() == 0){
				System.out.println("\n이미지파일 없이 수정할 때 IF문 진입");
				sql = "update review set title=?, content=? where idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, reviewVO.getTitle());
				pstmt.setString(2, reviewVO.getContent());
				pstmt.setInt(3, idx);
			}
			else{
				System.out.println("\n이미지 파일 같이 수정할 때 ELSE문 진입");
				sql = "update review set title=?, content=?, imageFileName=? where idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, reviewVO.getTitle());
				pstmt.setString(2, reviewVO.getContent());
				pstmt.setString(3, imageFileName);
				pstmt.setInt(4, idx);
			}
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			System.out.println("updateReview 메서드 에러 발생!");
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}	
		
	public void deleteReview(int idx) {
		try {
			con = getConnection();
			sql = "delete from reviewcomment where parentnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			sql = "delete from review where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteReview 메서드 에러 발생");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}

	public void updateReadCount(int idx){
		
		try {
			con=getConnection();
			sql = "update review set readcount=readcount+1 where idx=?";			
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1, idx);			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount 메서드 에러 발생!");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public int getlistCount() {
		int totalList=0;
		try {
			con=getConnection();
			sql="select count(*) from review";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
			totalList=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();			
		}
		return totalList;
	}
	
}
