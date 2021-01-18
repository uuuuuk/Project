package com.ode.notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/notice/*")
public class NoticeController extends HttpServlet{
	
	HttpSession session;
	NoticeService noticeService;
		
	@Override
	public void init() throws ServletException {
		noticeService=new NoticeService();
	}	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doHandle(request,response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doHandle(request,response);
	}
	
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");	
		response.setContentType("text/html; charset=utf-8");
		
		String path = "";
		String action = request.getPathInfo();										 
		System.out.println("NoticeControllerAction : " + action);
		
		PrintWriter pw = response.getWriter();	
		
		List<NoticeVO> noticeList=null;
		try {
			if(action.equals("/addNotice.do")){
				
				String email = request.getParameter("email");
				String writer = request.getParameter("writer");
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				NoticeVO noticeVO=new NoticeVO();
				noticeVO.setEmail(email);
				noticeVO.setWriter(writer);
				noticeVO.setTitle(title);
				SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
				String writeDate = dateFormatter.format(new java.util.Date());
				noticeVO.setWriteDate(writeDate);	
				noticeVO.setContent(content);
				noticeService.addNotice(noticeVO);
							
				path = "/main/listNotice.do";
			
			}else if(action.equals("/listNotice.do")){	
				
				PageInfo pageinfo=pageInfo(request, response);
							
				int startrow=((pageinfo.getPage())-1)*5;

				noticeList = noticeService.listNotice(startrow);
				
				request.setAttribute("noticeList", noticeList);
				request.setAttribute("pageinfo",pageinfo);
				System.out.println(noticeList);

				path = "/noticeView/noticeList.jsp";				
				
			}else if(action.equals("/viewNotice.do")){	
				int num=Integer.parseInt(request.getParameter("num"));	
				
				int idx=Integer.parseInt(request.getParameter("idx"));
				NoticeVO noticeVO=noticeService.viewNotice(idx);
				
				request.setAttribute("noticeView", noticeVO);
				request.setAttribute("num", num);
				
				
				path="/noticeView/noticeInfo.jsp";
				
			}else if(action.equals("/deleteNotice.do")){
				
				int idx=Integer.parseInt(request.getParameter("idx"));
				noticeService.deleteNotice(idx);
				
				path = "/main/listNotice.do";
				
			}else if(action.equals("/writeNotice.do")){
				path="/noticeView/noticeWrite.jsp";				
				
			}
	
				 RequestDispatcher dispatche = 
						 request.getRequestDispatcher(path);
				 dispatche.forward(request, response);
	
		 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	private PageInfo pageInfo(HttpServletRequest request,HttpServletResponse response){
		
		PageInfo pageinfo=new PageInfo();
		int page=1;
		int limit=5;
		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
			
		}		
		int listcount=noticeService.getlistCount();
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
		
	}		
}
