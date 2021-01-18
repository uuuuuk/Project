package com.ode.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {

	
	private Connection con;
	private DataSource ds;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
		
	
	private Connection getConnection() throws Exception {
		
		Context init = new InitialContext(); 
		
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/odetour");
		
		con = ds.getConnection();
		
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

	
	//
	public void newinsertNotice(NoticeVO noticeVO) {
		
		try {
			con = getConnection();
			
			System.out.println("newinsertNotice메서드");
			sql = "INSERT INTO notice(title, content, writer,readCount,writeDate,email)"
						 + " VALUES(?,?,?,?,?,?)";
		
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, noticeVO.getTitle());
			pstmt.setString(2, noticeVO.getContent());
			pstmt.setString(3, noticeVO.getWriter());
			pstmt.setInt(4, 0);
			pstmt.setString(5, noticeVO.getWriteDate());
			pstmt.setString(6, noticeVO.getEmail());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
			
		}
		
	}
	public List selectNotice(int startrow) {
		
		List noticeList = new ArrayList();	
		
		
		try {
			con = getConnection();
			
			sql = "select * from notice order by idx desc limit ?,5";	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			
			rs = pstmt.executeQuery();
						
			while(rs.next()){
				
				NoticeVO noticeVO=new NoticeVO();
				noticeVO.setTitle(rs.getString("title"));
				noticeVO.setWriter(rs.getString("writer"));
				noticeVO.setContent(rs.getString("content"));
				noticeVO.setReadCount(rs.getInt("readCount"));
				noticeVO.setWriteDate(rs.getString("writeDate"));
				noticeVO.setIdx(rs.getInt("idx"));
				
				noticeList.add(noticeVO);
				
			}	
	
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();			
		}
		
		return noticeList;
	}

	
	
	public NoticeVO viewNotice(int idx) {
		
		NoticeVO noticeVO=new NoticeVO();
		updateReadCount(idx);
		try {

			con = getConnection();		
					
			sql="select * from notice where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			rs=pstmt.executeQuery();
			rs.next();
			noticeVO.setIdx(rs.getInt("idx"));
			noticeVO.setTitle(rs.getString("title"));
			noticeVO.setWriter(rs.getString("writer"));
			noticeVO.setContent(rs.getString("content"));
			noticeVO.setReadCount(rs.getInt("readCount"));			
			noticeVO.setWriteDate(rs.getString("writeDate"));
			

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
			
		}
		return noticeVO;
		
		
	}
	public int updateReadCount(int idx){
		int count=0;
		try {
			
			con = getConnection();
			
			sql = "update notice set readcount=readcount+1 where idx=?";			
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1, idx);			
			pstmt.executeUpdate();
			
			sql="select readcount from notice where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);	
			rs=pstmt.executeQuery();
			rs.next();
			count=rs.getInt(1);
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return count;
	}

	public void deleteNotice(int idx) {
		try {
			
			con=getConnection();
			
			sql="delete from notice where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
			
		}
		
	}

	public int getlistCount() {
		int totalList=0;
		try {
			
			con=getConnection();
			
			sql="select count(*) from notice";
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
