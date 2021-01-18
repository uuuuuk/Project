package com.ode.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;

import com.ode.qna.qnaVO;

public class qnaService {
	qnaDAO qnaDAO;

	public qnaService() {
		qnaDAO = new qnaDAO();
	}
	
	public int insertDAO(qnaVO qnaVO){
		return qnaDAO.insertDAO(qnaVO);
	}
	
	public int WriteForm(qnaVO qnaVO){
		return qnaDAO.insertDAO(qnaVO);
	}

	public JSONArray Listselect(String email) {
		return qnaDAO.Listselect(email);
	}
	
	public Map<String,Object> info(int qnaNum) {
		return qnaDAO.QnaReplyInfo(qnaNum);
	}
	
	public void replyWrite(qnaVO vo){
		qnaDAO.replyWrite(vo);
	}
	
	public void qnaDel(int qnaNum){
		qnaDAO.qnaDel(qnaNum);
	}

	public int qnaRewrite(int qnaNum, String qnaTitle, String qnaContent) {
		return qnaDAO.qnaRewrite(qnaNum , qnaTitle , qnaContent);
	}

	public JSONArray getInformReply(String email) {
		return qnaDAO.getInformReply(email);
	}	
	
	public String getQnaList(String email) {
	      if(email == null) email = "";
	      StringBuffer result = new StringBuffer("");
	      result.append("{\"result\":[");
	      
	      qnaDAO qnaDAO = new qnaDAO();
	      ArrayList<qnaVO> qnaList = qnaDAO.adminQnaSearch(email);
	      for(int i=0;i<qnaList.size();i++) {
	         result.append("[{\"value\": \"" + qnaList.get(i).getQnaNum() + "\"},");
	         result.append("{\"value\": \"" + qnaList.get(i).getTitle() + "\"},");
	         result.append("{\"value\": \"" + qnaList.get(i).getEmail()+ "\"},");
	         result.append("{\"value\": \"" + qnaList.get(i).getWriter() + "\"},");
	         result.append("{\"value\": \"" + qnaList.get(i).getWriteDate() + "\"},");
	         result.append("{\"value\": \"" + qnaList.get(i).getAdminCheck() + "\"},");
	         result.append("{\"value\": \"" + "  " + "\"}],");
	      }
	      result.append("]}");
	      
	      return result.toString();
	      
	   }//getJSON

	
	public String getUnreadMessage(String email) {
		return qnaDAO.getAllUnreadMessage(email) + ""; 
	}

}
