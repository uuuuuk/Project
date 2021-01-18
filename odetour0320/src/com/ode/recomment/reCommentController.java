package com.ode.recomment;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ode.review.ReviewVO;

@WebServlet("/recomment/*")
public class reCommentController extends HttpServlet{
	reCommentService recommentService; 
	reCommentVO recommentVO;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		recommentService = new reCommentService(); 
		String nextPage =""; 
		String action = request.getPathInfo();
		System.out.println("reCommentController action : " + action);
		
		List<reCommentVO> recommentList;
		
 
		if(action.equals("/commentList.do")){
			String commentPageNum = request.getParameter("commentPageNum");  
			int commentRealPage = 0; 
			
			if (commentPageNum == null){
				commentRealPage = 0;
				
			}else {
				commentRealPage = Integer.parseInt(commentPageNum);
			}
			
			int parentNum = Integer.parseInt(request.getParameter("idx"));
			
			recommentList = recommentService.listreComment(parentNum, commentRealPage);
			int commentListSize = recommentService.getAllCommentSize(parentNum);
		
			request.setAttribute("recommentList", recommentList);
			request.setAttribute("recommentSize", recommentList.size());
			request.setAttribute("commentListSize", commentListSize);
			request.setAttribute("commentInit", commentRealPage);
			
			nextPage = "/reviewView/reviewInfo.jsp";
		
		}
		else if(action.equals("/mainReviewCommentSize.do")){
			List<ReviewVO> reviewList = (List<ReviewVO>) request.getAttribute("reviewList");
			List<Integer> reviewCommentSizeList = recommentService.getRecommentSize(reviewList);
			request.setAttribute("reviewList", reviewList);
			request.setAttribute("commentSize", reviewCommentSizeList);
			nextPage = "/mainView/index.jsp";
		}
		else if(action.equals("/reviewListCommentSize.do")){
			List<ReviewVO> reviewList = (List<ReviewVO>) request.getAttribute("reviewList");
			List<Integer> reviewCommentSizeList = recommentService.getRecommentSize(reviewList);
			request.setAttribute("reviewList", reviewList);
			request.setAttribute("commentSize", reviewCommentSizeList);
			nextPage = "/reviewView/reviewList.jsp";
		}
		else if(action.equals("/commentListPaging.do")){
			int commentPage = Integer.parseInt(request.getParameter("commentPage")) - 1;
			int reviewIdx = Integer.parseInt(request.getParameter("reviewIdx"));
			
			JSONArray commentList = recommentService.commentListPaging(reviewIdx, commentPage);
			
			response.getWriter().print(commentList);
			response.getWriter().flush();
			response.getWriter().close();
			return;
		}
		else if(action.equals("/commentWrite.do")){
			String strParentNum = request.getParameter("commentParentNum");
			int parentNum = Integer.parseInt(strParentNum);
			String email = request.getParameter("email");
			String name = request.getParameter("name");
			
			String content = request.getParameter("commentContent"); 
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd"); 
			String writeDate =dateFormatter.format(new java.util.Date()); 
			
			reCommentVO recommentVO =new reCommentVO(); 
			
			recommentVO.setParentNum(parentNum);
			recommentVO.setEmail(email);
			recommentVO.setWriter(name);
			recommentVO.setContent(content);
			recommentVO.setWriteDate(writeDate);
			
			recommentService.writeComment(recommentVO);
			
			nextPage = "/main/reviewInfo.do?idx=" + parentNum;

			
	
		}else if (action.equals("/commentModify.do")){
			
			int commentIdx = Integer.parseInt(request.getParameter("commentRealIdx"));
			String commentRewriteContext = request.getParameter("commentRewriteContext");
			int result = recommentService.modifyComment(commentIdx , commentRewriteContext);

			response.getWriter().write(result + "");
			response.getWriter().flush();
			response.getWriter().close();
			return;
			
		}else if(action.equals("/commentDelete.do")){
			
			int idx = Integer.parseInt(request.getParameter("realCommentIdx"));
			System.out.println(idx);
			
			int result = recommentService.deleteComment(idx);
			
			response.getWriter().write(result + "");
			response.getWriter().flush();
			response.getWriter().close();
			return;
		
		}
		
		 RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		 dispatch.forward(request, response);
		
	}
	
	
	

}
