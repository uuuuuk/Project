package com.ode.qna;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;

@WebServlet("/qna/*")
public class qnaController extends HttpServlet {

	qnaService qnaservice ;
	HttpSession session;
	
	@Override
	public void init() throws ServletException {
		qnaservice=new qnaService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
						throws ServletException, IOException {
		doHandle(request, response);
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
						throws ServletException, IOException {
		doHandle(request, response);
		
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) 
				throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");	
		response.setContentType("text/html; charset=utf-8");
		
		String action=request.getPathInfo();
		PrintWriter pw = response.getWriter();
		String path = "";
		try{
			if(request.getSession() != null){
				session = request.getSession();
			}
			
			System.out.println("QnAController Action : " + action);
			////////////////////// 첫화면 : 리스트 //////////////////////////////////
			if(action.equals("/getQnaList.do")){	
				String email = request.getParameter("email");
				System.out.println(email);
				JSONArray qnaList=qnaservice.Listselect(email); 
				response.getWriter().print(qnaList);
				response.getWriter().flush();
				response.getWriter().close();
				return;
				
			///////////////////// 글작성페이지 ////////////////////////////////////	
			}else if(action.equals("/qnaWrite.do")){
				
				qnaVO vo = new qnaVO();
				SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
				String writeDate = dateFormatter.format(new java.util.Date());
				
				vo.setWriter((String)session.getAttribute("name"));
				vo.setTitle(request.getParameter("title"));
				vo.setEmail((String)session.getAttribute("email"));
				vo.setContent(request.getParameter("content"));
				vo.setWriteDate(writeDate);
				int result = qnaservice.WriteForm(vo); 
				
				if(result == 1){
					pw.print("<script>"
							+ "location.href='"+request.getContextPath()+"/main/home.do';"
							+ "</script>");
				}
				return;
				
			////////////////// 글 상세보기 페이지 //////////////////////////////
			}else if(action.equals("/qnaInto.do")){
			
				int qnaNum= Integer.parseInt(request.getParameter("qnaNum")); 
					
				Map<String,Object> QnaReplyMap = qnaservice.info(qnaNum);
				request.setAttribute("QnaReplyMap", QnaReplyMap);
				
				//게시글
				path ="/qnaView/qnaInfo.jsp";
			}
			else if(action.equals("/qnaRewrite.do")){
				int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
				String qnaTitle = request.getParameter("qnaTitle");
				String qnaContent = request.getParameter("qnaContent");
				
				int result = qnaservice.qnaRewrite(qnaNum , qnaTitle , qnaContent);
				
				path = "/main/qnaInto.do?qnaNum="+qnaNum;
			}
			else if(action.equals("/adminQnaListPage.do")){
				path = "/memberView/qnaSearch.jsp";
			}
			
			else if(action.equals("/adminQnaSearch.do")){
				String email = request.getParameter("email");
				String result = qnaservice.getQnaList(email);
				response.getWriter().write(result);
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			
			///////////////// 글 삭제 하기 ///////////////////////
			else if(action.equals("/qnaDel.do")){
				
				int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
				qnaservice.qnaDel(qnaNum);
				
				pw.print("<script>" 
				         +"alert('삭제되었습니다.');" 
						 +" location.href='"+request.getContextPath()+"/main/home.do';"
				         +"</script>");
				return;
				
			}
			else if(action.equals("/getInformQnaReply.do")){
				String email = request.getParameter("email");
				JSONArray replyInform = qnaservice.getInformReply(email);
				
				response.getWriter().print(replyInform);;
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/messageUnread.do")){
				String email = request.getParameter("email");
				String result = qnaservice.getUnreadMessage(email);
				
				response.getWriter().write(result);
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/qnaReplyWrite.do")){
				SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
				String writeDate = dateFormatter.format(new java.util.Date());
				
				int parentNum = Integer.parseInt(request.getParameter("qnaNum"));
				qnaVO vo = new qnaVO();
				
				vo.setWriter("관리자");
				vo.setEmail("admin@odetour.com");
				vo.setContent(request.getParameter("replyTextArea"));
				vo.setParentNum(parentNum);
				vo.setWriteDate(writeDate);
				
				qnaservice.replyWrite(vo);		
				
				path = "/memberView/qnaSearch.jsp";
			
			}else if(action.equals( "/qnaWriteForm.do")){
				path = "/qnaView/qnaWrite.jsp";
			}
		}
		catch(Exception e){
			System.out.println("qnaController Error : " + e);
		}
		
		try{
			RequestDispatcher dis = request.getRequestDispatcher(path);
			dis.forward(request, response);
		}
		catch(Exception e){
			System.out.println("qnaController Dispatch Error : " + e);
			e.printStackTrace();
		}

		
		////////////////////////////////////////////////////////////////
		
		
		
		
		
		
		
		
		
		
				
}
	
	
	
}
