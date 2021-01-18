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
//DB�� ������ ��� �۾� �ϴ� Ŭ���� 
public class BoardDAO {
		
	Connection con = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;		
	String sql = "";	
	
	
	//jspbeginner�����ͺ��̽��� ������ �δ� �޼ҵ�
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		//Ŀ�ؼ�Ǯ ���
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		//Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼǰ�ü(DB�� �̸� ���� �Ǿ� �ִ� ������ �˸��� ��ü) ��������
		con = ds.getConnection();
		
		return con;
	} // getConnection�޼ҵ� �ݴºκ�
	
	
	
	
	
	/*
	 
	 �亯 �ޱ� ���� ����
	 re_ref -> �θ�۰� �׷κ��� �Ļ��� �ڽ�(�亯) �۵��� ���� ���� ������ ���� �����ǰ�
	 re_seq -> ���� �׷� �۵� �������� ����
	 re_lev -> ���� �׷쳻������ ����(�鿩���� ���� ����)
	 
	 
	 �亯�ޱ� ��Ģ ����
	 ����1) re_ref���� �θ��(�ֱ�)�� �׷��ȣ(re_ref)�� ����ؾ���
	 ����2) re_seq ���� �θ���� re_seq���� +1 ���� �� ���� ��� �ؾ���.
	 ����3) re_lev ���� �θ���� re_lev���� .. +1 ������ ���� ��� �ؾ���.
	 
	 */
	
	
	 // �亯�� �߰� �޼ҵ�
	public void reInsertBoard(BoardBean bBean){
		
		int num = 0;
		
		try {
			// DB����
			con = getConnection();
			// �߰��� �亯���� �۹�ȣ ���ϱ�
			// -> ������ ����Ǿ� �ִ� ���� �ֽű۹�ȣ �˻��ؿ���
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// �˻��� �ֽű۹�ȣ�� ���� �ϸ�
			if(rs.next()){
				// �߰��� �亯���� �۹�ȣ = �˻��� �ֽű۹�ȣ + 1
				num = rs.getInt(1) + 1;
				
			}else{
				num = 1;
			}
			// re_seq ��ۼ��� ���ġ
			// �θ�� �׷�� ���� �׷��̸鼭.. �θ���� seq������ ū �亯�۵���?
			// seq���� 1���� ��Ų��.
			sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref()); // �θ���� �׷��ȣ
			pstmt.setInt(2, bBean.getRe_seq()); // �θ���� �� �Է� ����
			pstmt.executeUpdate();
			
			// �亯�� �ޱ�
			// insert								now()�Լ� => ���糯¥�� ��ȯ(sysdate)�� ����
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setString(6, bBean.getFile());
			pstmt.setInt(7, bBean.getRe_ref()); // �θ�� �׷��ȣ re_ref���� ����Ѵ�.
			pstmt.setInt(8, bBean.getRe_lev() + 1); // �θ���� re_lev�� +1�� �Ͽ� �鿩���� ���� ����Ѵ�.
			pstmt.setInt(9, bBean.getRe_seq() + 1);
			pstmt.setInt(10, 0); // �亯���� ��ȸ��
			pstmt.setString(11, bBean.getIp()); // �亯���� �ۼ��ϴ� ����� IP�ּ�
			
			
			// �亯 INSERT
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
		System.out.println("reInsertBoard �޼ҵ� ����: " + e);
			
		
		}finally{
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	
	}
	
	
	
	
	// ������ ������(BoardBean)��ü�� �Ű������� ���� �޾�.. DB�� �����ϴ� ��й�ȣ��
	// �ۼ��� ȭ�鿡�� �Է��� ��й�ȣ�� ��ġ�ϸ�? �� ���� UPDATE
	public int updateBoard(BoardBean bBean){
		int check = 0;
		
		try {
			// DB����
			con = getConnection();
			
			// SELECT���� -> ������ �۹�ȣ�� �ش��ϴ� ��й�ȣ �˻�
			sql = "select passwd from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1; // ���ؼ� ������ 1
					sql = "update board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					
					
					pstmt.executeUpdate();
					
					
					
					
				}else{
					check = 0; // ���ؼ� �ٸ��� 0
				}
				
			}
			
		} catch (Exception e) {
		System.out.println("updateBoard�޼ҵ� ����: "+ e);
			
		}finally{
		
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
			
		}
		return check;
		
	}
	
	
	
	
	
	
	// ������ �۹�ȣ�� ������ ���� ��й�ȣ�� �Ű������� ���� �޾�.. ���� DELETE���� �ϴ� �޼ҵ�
	public int deleteBoard(int num, String passwd){
		
		int check = 0; // ���� ����, ���� ���� �Ǵܰ� 1�Ǵ� 0 ������ ����
		
		try{
			// DB����
			con = getConnection();
			
			// �Ű������� ���޹��� ������ �� ��ȣ�� �ش��ϴ� ��й�ȣ �˻�
			sql = "select passwd from board where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//�˻�
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // �˻��� ���� ���� �ϸ�
				
				if(passwd.equals(rs.getString("passwd"))){
					check = 1;
					
					// �Ű������� ���� ���� �۹�ȣ�� �ش� �ϴ� �ۻ���
					sql ="delete from board where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					// DELETE ����
					pstmt.executeUpdate();
					
				}else{ // �Է��� ��й�ȣ�� DB�� ���� ���� ������
					check = 0;
				}
				
			}
			
		}catch(Exception err){
			err.printStackTrace();
			
		}finally{
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		return check; // ��й�ȣ ��ġ ���� 1�Ǵ� 0�� ����
		
	}
	
	
	
	
	
	
	
	
	
	// �۹�ȣ�� �Ű������� ���޹޾�.. �۹�ȣ�� �ش��ϴ� �ϳ��� �� �˻�
	public BoardBean getBoard(int num){ // content.jsp���� ȣ�� �� �޼ҵ�
		
		BoardBean boardBean = null;
		
		try {
			// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB�� �̸� ������ ���� Connection��ü ���)
			con = getConnection();
			
			// �Ű������� ���� ���� �۹�ȣ�� �ش�Ǵ� �� �˻� SQL��
			sql = "select * from board where num=?";
			
			// select������ ������ ��ü ���
			pstmt = con.prepareStatement(sql);
			
			// ?�� �����Ǵ� �� ��ȣ ����
			pstmt.setInt(1, num);
			
			// select ������ �˻��� �ϳ��� �������� ResultSet �ӽ�����ҿ� ���� �Ͽ� ��ȯ
			rs = pstmt.executeQuery();
			
			
			if(rs.next()){ // �˻��� ���� ���� �ϸ�
				
				boardBean = new BoardBean(); // �˻��� ������ rs���� �����ͼ� ������ �뵵
				
				// setter�޼ҵ带 Ȱ�� �ؼ� ������ �˻��� ������ ����
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
				
				} // if��
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
		
		
		return boardBean; // BoardBean ��ü ����
		
		
	} // �޼ҵ� ��
	
	
	
	// �۹�ȣ�� �Ű������� ���޹޾�.. �۹�ȣ�� �ش��ϴ� �ϳ��� �� �˻�
		public BoardBean getfileBoard(int num){ // review.jsp���� ȣ�� �� �޼ҵ�
			BoardBean boardBean = null;
			
			try {
				// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB�� �̸� ������ ���� Connection��ü ���)
				con = getConnection();
				
				// �Ű������� ���� ���� �۹�ȣ�� �ش�Ǵ� �� �˻� SQL��
				sql = "select * from fileboard where num=?";
				
				// select������ ������ ��ü ���
				pstmt = con.prepareStatement(sql);
				
				// ?�� �����Ǵ� �� ��ȣ ����
				pstmt.setInt(1, num);
				
				// select ������ �˻��� �ϳ��� �������� ResultSet �ӽ�����ҿ� ���� �Ͽ� ��ȯ
				rs = pstmt.executeQuery();
				
				
				if(rs.next()){ // �˻��� ���� ���� �ϸ�
					System.out.println(rs.getString("file"));
					System.out.println(rs.getInt("num"));
					System.out.println(rs.getString("content"));
					boardBean = new BoardBean(); // �˻��� ������ rs���� �����ͼ� ������ �뵵
					
					// setter�޼ҵ带 Ȱ�� �ؼ� ������ �˻��� ������ ����
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
					} // if��
			
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				//�ڿ�����
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			
			
			return boardBean; // BoardBean ��ü ����
			
			
		} // �޼ҵ� ��
	
	
	
	
	
	// �۹�ȣ�� �Ű������� ���� �޾�.. �۹�ȣ�� �ش�Ǵ� ���� ��ȸ�� 1���� ��Ű�� �޼ҵ�
	public void updateReadCount(int num){ // content.jsp���� ȣ�� �ϴ� �޼ҵ�
		
		try {
			// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB�� �̸� ������ ���� Connection��ü ���)
			con = getConnection();
			
			sql = "update board set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
					
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		
		} catch (Exception e) {

			
			e.printStackTrace();
		}finally {
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			
		}
	}
	
	
	
	
	// �۹�ȣ�� �Ű������� ���� �޾�.. �۹�ȣ�� �ش�Ǵ� ���� ��ȸ�� 1���� ��Ű�� �޼ҵ�
		public void updatefileReadCount(int num){ // review.jsp���� ȣ�� �ϴ� �޼ҵ�
			
			try {
				// Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB�� �̸� ������ ���� Connection��ü ���)
				con = getConnection();
				
				sql = "update fileboard set readcount=readcount+1 where num=?";
				
				pstmt = con.prepareStatement(sql);
						
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				System.out.println("ī��Ʈ����");
			} catch (Exception e) {

				
				e.printStackTrace();
			}finally {
				//�ڿ�����
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
		}
	
	
	
	
	//�������� ���� ������ ù��°�� ������ ���۱۹�ȣ, ���������� ������ �۰����� �Ű������� ���� �޾�.
	//SELECT�˻��� ����� ArrayList�� ������ ���� �ϴ� �޼ҵ� 
	public List<BoardBean> getBoradList(int startRow,int pageSize){
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try{
			//Connection��ü ��� 
			con = getConnection();
			//SELECT���� ����� 
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			//SELECT���� ������ PreparedStatement���� ��ü ���
			pstmt = con.prepareStatement(sql);
			//?�� ����
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			//SELECT���� ������ �˻� �� ��� �ޱ�
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bBean = new BoardBean();
				//rs => BoardBean��ü�� �������� ����
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
					
				//BoardBean��ü => ArrayList�迭�� �߰�
				boardList.add(bBean);

			}//while��			
			
		}catch(Exception err){
			System.out.println("getBoardList�޼ҵ� ���ο��� ���� : " + err);
		}finally {
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardList;//ArrayList��ȯ
	}
	
	
	//�������� ���� ������ ù��°�� ������ ���۱۹�ȣ, ���������� ������ �۰����� �Ű������� ���� �޾�.
		//SELECT�˻��� ����� ArrayList�� ������ ���� �ϴ� �޼ҵ� 
		public List<BoardBean> getfileBoradList(int startRow,int pageSize){
			
			List<BoardBean> boardList = new ArrayList<BoardBean>();
			
			try{
				//Connection��ü ��� 
				con = getConnection();
				
				//SELECT���� ����� 
				sql = "select * from fileboard order by re_ref desc, re_seq desc limit ?,?";
				
				//SELECT���� ������ PreparedStatement���� ��ü ���
				pstmt = con.prepareStatement(sql);
				//?�� ����
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);

				//SELECT���� ������ �˻� �� ��� �ޱ�
				rs = pstmt.executeQuery();
				
				
				
				while (rs.next()) {
					System.out.println("1");
					BoardBean bBean = new BoardBean();
					//rs => BoardBean��ü�� �������� ����
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
					
						
					//BoardBean��ü => ArrayList�迭�� �߰�
					boardList.add(bBean);
				}//while��	
				
				
			}catch(Exception err){
				System.out.println("getfileBoardList�޼ҵ� ���ο��� ���� : " + err);
			}finally {
				//�ڿ�����
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return boardList;//ArrayList��ȯ
		}
	
	
	
	
	
	
	//�Խ��ǿ� ����Ǿ� �ִ� ��ü �� ���� �˻� �޼ҵ�
	public int getBoardCount(){
		
		int count = 0;//�˻��� ��ü �� ������ ������ ���� 
		
		try {
			//Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB���������� ���ϰ� �ִ� Connection���)
			con = getConnection();
			//sql SELECT-> ��ä �۰��� �˻�
			sql = "select count(*) from board";
			//SELECT�� ���� ��ü ���
			pstmt = con.prepareStatement(sql);
			//SELECT�� ���� �� �˻��� ��� ���
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);//�˻��� ���� ���� 
			}
		
		} catch (Exception e) {
			System.out.println("getBoardCount()�޼ҵ� ���� : " + e);
		} finally {
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
	
	
	//����Խ��� ���
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
			//System.out.println("�����ϿϷ�!");
			
		} catch (Exception e) {
			System.out.println("setfileBoard�޼��� ����!"+e);
		} finally {
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	//�Խ��ǿ� ����Ǿ� �ִ� ��ü �� ���� �˻� �޼ҵ�
		public int getfileBoardCount(){
			
			int count = 0;//�˻��� ��ü �� ������ ������ ���� 
			
			try {
				//Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB���������� ���ϰ� �ִ� Connection���)
				con = getConnection();
				//sql SELECT-> ��ä �۰��� �˻�
				sql = "select count(*) from fileboard";
				//SELECT�� ���� ��ü ���
				pstmt = con.prepareStatement(sql);
				//SELECT�� ���� �� �˻��� ��� ���
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//�˻��� ���� ���� 
				}
			
			} catch (Exception e) {
				System.out.println("getfileBoardCount()�޼ҵ� ���� : " + e);
			} finally {
				//�ڿ�����
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return count;
		}
	
	
	//�Խ��� ���� �߰�(�ֱ�)
	//-> writePro.jsp���� insertBoard()�޼ҵ� ȣ���.. 
	//   ������ BoardBean��ü�� �̿��Ͽ� insert SQL���� ������.
	public  void inserBoard(BoardBean bBean){		
		
		int num = 0; //�߰��� �۹�ȣ ���� �뵵	
		try{
			//Ŀ�ؼ�Ǯ�� ���� Ŀ�ؼ� ��ü ��� (DB���������� ���ϰ� �ִ� Connection���)
			con = getConnection();
			//���� �߰���..�۹�ȣ ���ϱ�
			//-> board���̺� ����Ǿ� �ִ� ���� ū�۹�ȣ ���
			//->���� ���� ��� : �۹�ȣ 1 �� ����
			//->���� ���� ��� : �ֱ� �۹�ȣ(��ȣ�� ����ū��) + 1 �� ����
			sql = "select max(num) from board";//���� ū�۹�ȣ �˻�
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//�˻��� �����Ͱ� ���� �ϸ�?
				num = rs.getInt(1) + 1; //���� ���� ��� �ִ�۹�ȣ + 1
			}else{//�˻��� ���� ������?
				num = 1; //���� ���� ��� 
			}
			//insert���� �����
			sql = "insert into board "
				+ "(num,name,passwd,subject,"
				+ "content,file,re_ref,re_lev,"
				+ "re_seq,readcount,date,ip)"
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			//insert������ ������ PreparedStatement��� 
			pstmt = con.prepareStatement(sql);
			//?���� �Ǵ� �߰��� ���� ����
			pstmt.setInt(1, num);//�߰��� ���۹�ȣ
			pstmt.setString(2, bBean.getName());//������ �߰��� �ۼ��� �̸�
			pstmt.setString(3, bBean.getPasswd());//�߰��� ������ ��й�ȣ
			pstmt.setString(4, bBean.getSubject());//�߰��� ������ ������
			pstmt.setString(5, bBean.getContent());//�߰��� ������ �۳���
			pstmt.setString(6, bBean.getFile());//�߰��� ���� �������� ���ε��� ���ϸ�
			pstmt.setInt(7, num);// num �ֱ۹�ȣ ���� == re_ref �׷��ȣ
			pstmt.setInt(8, 0);//�߰��� ������ �鿩���� ������ re_lev
			pstmt.setInt(9, 0);//�� ���� re_seq
			pstmt.setInt(10, 0);//�߰��� ���� ��ȸ�� readcount 0
			pstmt.setTimestamp(11, bBean.getDate());//�� �ۼ� ��¥
			pstmt.setString(12, bBean.getIp());//�۾������ IP�ּ� 
			
			//insert����
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("insertBoard�޼ҵ� ���ο��� ����:" + e);
		}finally {
			//�ڿ�����
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}		
	}//insertBoard�޼ҵ� �ݴ� �κ�
	
}//BoardDAO�ݴ� �κ�






