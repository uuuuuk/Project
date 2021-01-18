package com.ode.review;

import java.util.List;

import com.ode.notice.NoticeVO;



public class ReviewService {
	ReviewDAO reviewDAO; 

	
	public ReviewService(){
		reviewDAO = new ReviewDAO(); 
	}	
//	public List<ReviewVO> listReview(int realPage) {
//		List<ReviewVO> reviewList= reviewDAO.allReview(realPage);
//		return reviewList;
//	}
	public List<ReviewVO> listReview(int startrow) {
		List reviewList = reviewDAO.allReview(startrow);		
		return reviewList;
	}
	
	public void writeReview(ReviewVO reviewVO) {
		reviewDAO.insertReview(reviewVO);
	}
	public ReviewVO viewReview(int idx) {
		return reviewDAO.selectReview(idx);
	}

	public void modifyReview(int idx, ReviewVO reviewVO) {
		reviewDAO.updateReview(idx, reviewVO);		
	}
	
	
	public void deleteReview(int idx) {
		reviewDAO.deleteReview(idx);

	}
	public int getAllListSize() {
		return reviewDAO.getAllListSize();
	}
	
	public int getlistCount() {
		return reviewDAO.getlistCount();
	}


	
}
