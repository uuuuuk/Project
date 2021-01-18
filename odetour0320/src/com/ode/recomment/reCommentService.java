package com.ode.recomment;

import java.util.List;

import org.json.simple.JSONArray;

import com.ode.review.ReviewVO;

public class reCommentService {
	reCommentDAO recommentDAO;
	
	public reCommentService() {
		recommentDAO = new reCommentDAO();
	}

	public  List<reCommentVO> listreComment(int parentNum, int commentRealPage ) {
		
		List<reCommentVO>recommentList = recommentDAO.allComment(parentNum, commentRealPage);
		
		return recommentList;
	}


	public void writeComment(reCommentVO recommentVO) {
		recommentDAO.insertComment(recommentVO);
	}
	
	public int modifyComment(int idx , String content) {
		return recommentDAO.updateComment(idx,content); 
	}

	public int deleteComment(int idx) {
		return recommentDAO.deleteComment(idx);
	}

	public int getAllCommentSize(int parentNum) {
	
		return recommentDAO.getAllCommentSize(parentNum);
	}

	public JSONArray commentListPaging(int parentNum, int commentPage) {
		return recommentDAO.commentListPaging(parentNum , commentPage);
	}

	public List<Integer> getRecommentSize(List<ReviewVO> reviewList) {
		return recommentDAO.getCommentSize(reviewList);
	}


	

	

}
