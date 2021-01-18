package com.ode.member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;


public class MemberService {
	
	MemberDAO memberDAO;
	
	public MemberService() {
		memberDAO = new MemberDAO();
	}
	
	public int addMember(String name, String pwd, String email, String birth, String tel) {
		return memberDAO.registerMember(name, pwd, email, birth, tel);
	}
	public int emailDuplChk(String totalEmail){
		return memberDAO.getEmailDuplChk(totalEmail);
	}
	public int rewritePwd(String email,String rewritePwd) {
		return memberDAO.memberRewritePwd(email,rewritePwd);
	}
	public String emailAuthNumSend(String totalEmail) {
		MailSend mailSend = new MailSend();
		String userEmail = totalEmail;
		String adminAuthNum = mailSend.MailSending(userEmail);
		System.out.println(adminAuthNum);
		return adminAuthNum;
	}
	
	public Map<String,Object> memberLoginChk(String email, String passwd) {
		return memberDAO.memberLoginChk(email,passwd);
	}
	

	public MemberVO memberInfo(String name, String email) {
		return memberDAO.memberInfo(name,email);
	}
	
	public int memberModify(String email, String pwd) {
		return memberDAO.memberModify(email,pwd);
	}
	
	public int memberDelete(String email) {
		return memberDAO.memberDelete(email);
	}
	
	public int adminAuthMemberDelete(String tel) {
		return memberDAO.adminAuthMemberDelete(tel);
	}
	
	public String getJSON(String name) {
	      if(name == null) name = "";
	      StringBuffer result = new StringBuffer("");
	      result.append("{\"result\":[");
	      
	      MemberDAO memberDAO = new MemberDAO();
	      ArrayList<MemberVO> memberList = memberDAO.memberSearch(name);
	      for(int i=0;i<memberList.size();i++) {
	         result.append("[{\"value\": \"" + memberList.get(i).getName() + "\"},");
	         result.append("{\"value\": \"" + memberList.get(i).getEmail() + "\"},");
	         result.append("{\"value\": \"" + memberList.get(i).getBirth_year() + memberList.get(i).getBirth_month() + memberList.get(i).getBirth_day() + "\"},");
	         result.append("{\"value\": \"" + memberList.get(i).getPoint() + "\"},");
	         result.append("{\"value\": \"" + memberList.get(i).getTel() + "\"},");
	         result.append("{\"value\": \"" +  " "  + "\"}],");
	         
	      }
	      result.append("]}");
	      System.out.println("getJSON() memberList => "+result.toString());
	      
	      return result.toString();
	      
	   }//getJSON
	

private class MailSend {
	public String MailSending(String useremail){
		String adminAuthNum = "";
		for(int i = 0 ; i < 6 ; i++){
			adminAuthNum += ((int)(Math.random() * 10) + 1);
		}
		InternetAddress to = null;
		Properties prop = new Properties();
		// TLS : Transport Layer Security
		prop.put("mail.smtp.host", "smtp.naver.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		
		Authenticator auth = new MailAuth();
		
		Session session = Session.getDefaultInstance(prop , auth);
		
		MimeMessage msg = new MimeMessage(session);
		try {
			msg.setSentDate(new Date());
			
			msg.setFrom(new InternetAddress("jeongcode@naver.com" ,"Project"));
		
			to = new InternetAddress(useremail);
			msg.setRecipient(Message.RecipientType.TO, to);
			msg.setSubject("odeTour 占쏙옙占쏙옙 占쏙옙호 ","UTF-8");
			msg.setText("占쏙옙占쏙옙 占쏙옙호 : [" + adminAuthNum + "]","UTF-8");
			Transport.send(msg);
			System.out.println("占싱몌옙占쏙옙 占쏙옙占쏙옙 占싹뤄옙");
		} catch (AddressException e){
			System.out.println("AddressException Error : " + e);
		} catch (MessagingException e) {
			System.out.println("MessagingException Error : " + e);
		} catch (UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e);
		}
		return adminAuthNum;
	}
}
private class MailAuth extends Authenticator{

	PasswordAuthentication pa;
	
	public MailAuth(){
		String mail_id = "jeongcode@naver.com";
		String mail_pw = "ham1194!@";
		
		pa = new PasswordAuthentication(mail_id, mail_pw);
	}
	public PasswordAuthentication getPasswordAuthentication(){
		return pa;
	}
}





	
	
	
	
	
	
	
	
	
	
	
}
