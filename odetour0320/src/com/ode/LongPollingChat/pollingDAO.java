package com.ode.LongPollingChat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class pollingDAO {
	Connection conn;
	
	public pollingDAO(){
		try{
			 String dbURL = "jdbc:mysql://localhost:3306/itwill";
	            String dbID = "root";
	            String dbPassword = "1234"; 
	            Class.forName("com.mysql.jdbc.Driver");
	            conn = (Connection) DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	public int submit(String name, String messasge){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "insert into polling values (NULL,?,?)";
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,name );
			pstmt.setString(2, messasge);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				
				if(rs != null){
					rs.close();
				}
				if(pstmt != null){
					pstmt.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return 0;
		
		
	}
	
	
	
}
