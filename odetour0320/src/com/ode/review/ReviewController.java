package com.ode.review;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import com.ode.notice.PageInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/review/*")
public class ReviewController extends HttpServlet {
	private int maxSize = 1024*1024*10; 
	
	ReviewService reviewService;  
	ReviewVO reviewVO;
	
	@Override
	public void init() throws ServletException {
		reviewService = new ReviewService();  
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
		String nextPage =""; 
		String action = request.getPathInfo();
		System.out.println("ReviewController action =  "+ action);
		
		HttpSession session = request.getSession();
		List<ReviewVO> reviewList=null;
		
		try {
		
			if(action.equals("/reviewList.do")){	
			
				PageInfo pageinfo=pageInfo(request, response);
							
				int startrow=((pageinfo.getPage())-1)*5;
		
				reviewList = reviewService.listReview(startrow);    
				
				request.setAttribute("reviewList", reviewList);
				request.setAttribute("pageinfo",pageinfo);
				
				nextPage = "/recomment/reviewListCommentSize.do";	
			}
			else if(action.equals("/mainReviewList.do")){
				
				String pageNum =request.getParameter("pageNum"); // 최초는 0 
				int realPage = 0 ;
				// 페이지를 누르게 되면 거기에 맞는 번호
				if(pageNum == null){
					realPage = 0;
				}else{
					realPage = Integer.parseInt(pageNum);
				}
				
				String imageFilePath = request.getContextPath();
				request.setAttribute("imageFilePath", imageFilePath);
				
				reviewList = reviewService.listReview(realPage);
				
				int reviewListSize = reviewService.getAllListSize();
				
				request.setAttribute("reviewList", reviewList);
				request.setAttribute("reviewSize", reviewListSize);// 리뷰리스트가 모든 리스트 가지고 있으니깐 size를 가지고 온다 
				request.setAttribute("reviewInit", realPage); // 제일 초기화 페이징 초기화 
				
				nextPage = "/main/mainReviewCommentSize.do";
			}
			else if(action.equals("/reviewWriteForm.do")){
				
				nextPage="/reviewView/reviewWrite.jsp";
				
			}else if(action.equals("/reviewWrite.do")){
				
				String sessionEmail = (String)session.getAttribute("email");
				String realPath = getServletContext().getRealPath("/upload/");
				System.out.println("ReviewImageWrite Path : " + realPath);
				File imageFile = new File(realPath + sessionEmail);
				
				imageFile.mkdir();
				
				MultipartRequest multi = new MultipartRequest(request, realPath+sessionEmail, maxSize, "utf-8", new DefaultFileRenamePolicy());
				String title = multi.getParameter("title"); 
				String writer = multi.getParameter("name");
				String domain = multi.getParameter("domain");
				String content = multi.getParameter("content"); 
				SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
				String imageFileName= multi.getFilesystemName("imageFileName");
				System.out.println(imageFileName);
				String writeDate = dateFormatter.format(new java.util.Date());
				
				ReviewVO reviewVO = new ReviewVO();
				
				reviewVO.setTitle(title);
				reviewVO.setWriter(writer);
				reviewVO.setContent(content);
				reviewVO.setEmail(sessionEmail);
				reviewVO.setDomain(domain);
				reviewVO.setWriteDate(writeDate);
				reviewVO.setImageFileName(imageFileName);
				
				reviewService.writeReview(reviewVO);
				
				nextPage = "/main/reviewList.do";
				
			}else if(action.equals("/reviewInfo.do")){

				int idx = Integer.parseInt(request.getParameter("idx"));
				ReviewVO reviewVO = reviewService.viewReview(idx);
				String imageFilePath = request.getContextPath();
				request.setAttribute("imageFilePath", imageFilePath);
				request.setAttribute("reviewView", reviewVO);
				
				nextPage="/main/commentList.do";
				
			}else if(action.equals("/reviewUpdate.do")){
				
				String sessionEmail = (String)session.getAttribute("email");
				String realPath = getServletContext().getRealPath("/upload/");
				File imageFile = new File(realPath + sessionEmail);
				
				imageFile.mkdir();
				
				MultipartRequest multi = new MultipartRequest(request, realPath+sessionEmail, maxSize, "utf-8", new DefaultFileRenamePolicy());
				
				int idx = Integer.parseInt(multi.getParameter("idx"));
				
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setTitle(multi.getParameter("title"));
				reviewVO.setContent(multi.getParameter("content"));
				reviewVO.setImageFileName(multi.getFilesystemName("imageFileName"));
				
				reviewService.modifyReview(idx, reviewVO);
				
				nextPage="/main/reviewList.do";
			
			}else if(action.equals("/reviewDelete.do")){
				
				int idx = Integer.parseInt(request.getParameter("idx"));
				reviewService.deleteReview(idx);
				nextPage = "/main/reviewList.do";
			}
	
			 RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			 dispatch.forward(request, response);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}//doHandle끝
	
	/*PAGING*/
	private PageInfo pageInfo(HttpServletRequest request,HttpServletResponse response){
		
		PageInfo pageinfo=new PageInfo();
		int page=1;
		int limit=5;
		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
			
		}		
		int listcount=reviewService.getlistCount();
		
		int maxPage=(int)((double)listcount/limit+0.98);
		int startPage=(((int)((double)page/5+0.9))-1)*5+1;
		int endPage=startPage+5-1;
		
		if(endPage>maxPage) endPage=maxPage;
		pageinfo.setEndPage(endPage);
		pageinfo.setMaxPage(maxPage);
		pageinfo.setPage(page);
		pageinfo.setStartPage(startPage);
		pageinfo.setListCount(listcount);
			
		return pageinfo;		
		
	}//pageInfo		
	
	
}// 서블릿끝
