package com.ode.main;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.json.simple.JSONObject;

import com.ode.member.MemberController;
import com.ode.member.MemberVO;

@WebServlet("/main/*")
public class MainController extends HttpServlet {
	HttpSession session;
	MemberController memberController;
	
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
	@SuppressWarnings("unchecked")
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		session = request.getSession();
		
		memberController = new MemberController();
		
		String viewPage = "";
		String action = request.getPathInfo();
		System.out.println("MainController Action : " + action);
		
		try{
			if(action.equals("/home.do")){
				viewPage = "/review/mainReviewList.do";
			// ************************* <Member>
			}
			else if(action.equals("/memberEmailDuplChk.do")){
				String email = request.getParameter("email");
				String emailDomain = request.getParameter("emailDomain");
				String totalEmail = email + emailDomain;
				
				response.getWriter().write(memberController.emailDuplChk(totalEmail) + "");
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/memberAdd.do")){
				String email = request.getParameter("email");
				String name = request.getParameter("name");
		 		String pwd = request.getParameter("pwd");
				String birth = request.getParameter("birth");
				String tel = request.getParameter("tel");
				int result = memberController.addMember(name , pwd , email , birth , tel );
				
				response.getWriter().write(result + "");
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/memberLoginChk.do")){
				String email = request.getParameter("email");
				String pwd = request.getParameter("pwd");
				Map<String,Object> loginStatMap = memberController.memberLoginChk(email , pwd);
				int loginResult = (Integer)loginStatMap.get("loginResult");
				if(loginResult == 1){
					Map<String,String> namedomainMap = (Map<String, String>) loginStatMap.get("namedomainMap");
					String name = namedomainMap.get("name");
					String domain = namedomainMap.get("domain");
					System.out.println("Login name:"+name+", domain:"+domain);
					session.setAttribute("domain", domain);
					session.setAttribute("name", name);
					session.setAttribute("email", email);
					session.setAttribute("messageType", "로그인 Message");
					session.setAttribute("messageContent", name+"님이 로그인 하셨습니다.");
					response.getWriter().write(1+"");
				}
				else {
					//session.setAttribute("messageType", "로그인 오류 메세지");
					//session.setAttribute("messageContent", "이메일과 비밀번호를 다시 확인해주세요.");
					response.getWriter().write(0+"");
				}
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/memberEmailAuthNumSend.do")){
				String totalEmail = request.getParameter("totalEmail");
				String authNum = memberController.emailAuthNumSend(totalEmail);
				response.getWriter().print(authNum);
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/memberMypageInfo.do")){
				String name = (String)session.getAttribute("name");
				String email = (String)session.getAttribute("email");
				
				MemberVO memberVO = memberController.memberInfo(name,email);
				String birth = memberVO.getBirth_year() + memberVO.getBirth_month() + memberVO.getBirth_day();
				
				JSONObject json = new JSONObject();
				
				json.put("email", memberVO.getEmail());
				json.put("name", memberVO.getName());
				json.put("birth", birth);
				json.put("point", memberVO.getPoint());
				json.put("tel", memberVO.getTel());
				
				response.getWriter().print(json);
				response.getWriter().flush();
				response.getWriter().close();
				
				return;
			}
			else if(action.equals("/memberDelete.do")){
				String email = (String)session.getAttribute("email");
				int result = memberController.memberDelete(email);
				session.invalidate();
				response.getWriter().print(result + "");
				response.getWriter().flush();
				response.getWriter().close();
				
				return;
			}
			else if(action.equals("/adminSearch.do")){
				viewPage = "/member/adminSearch.do";
			}
			else if(action.equals("/memberLogout.do")){
				viewPage = "/member/memberLogout.do";
			}
			else if(action.equals("/adminSearchPage.do")){
				viewPage = "/member/adminSearchPage.do";
			}
			else if(action.equals("/memberRewritePwd.do")){
				String rewritePwd = request.getParameter("pwd");
				String email = (String)session.getAttribute("email");
				int result = memberController.rewritePwd(email,rewritePwd);
				
				response.getWriter().print(result + "");
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/adminAuthMemberDelete.do")){
				viewPage = "/member/adminAuthMemberDelete.do";
			}
			// ************************* <Notice>
			else if(action.equals("/addNotice.do")){
				viewPage = "/notice/addNotice.do";
			}
			else if(action.equals("/listNotice.do")){
				viewPage = "/notice/listNotice.do";
			}
			else if(action.equals("/viewNotice.do")){
				viewPage = "/notice/viewNotice.do";
			}
			else if(action.equals("/deleteNotice.do")){
				viewPage = "/notice/deleteNotice.do";
			}
			else if(action.equals("/writeNotice.do")){
				viewPage = "/notice/writeNotice.do";
			}
			// ************************* <Chat>
			else if(action.equals("/chatSubmit.do")){
				viewPage = "/chat/chatSubmit.do";
			}
			else if(action.equals("/getChatList.do")){
				viewPage = "/chat/getChatList.do";
			}
			// ************************* <QNA>
			else if(action.equals("/getQnaList.do")){
				viewPage = "/qna/getQnaList.do";
			}
			else if(action.equals("/qnaWrite.do")){
				viewPage = "/qna/qnaWrite.do";
			}
			else if(action.equals("/qnaInto.do")){
				viewPage = "/qna/qnaInto.do";
			}
			else if(action.equals("/qnaDel.do")){
				viewPage = "/qna/qnaDel.do";
			}
			else if(action.equals("/qnaWriteForm.do")){
				viewPage = "/qna/qnaWriteForm.do";
			}
			else if(action.equals("/qnaRewrite.do")){
				viewPage = "/qna/qnaRewrite.do";
			}
			else if(action.equals("/replyWrite.do")){
				viewPage = "/qna/qnaReplyWrite.do";
			}
			else if(action.equals("/adminQnaSearch.do")){
				viewPage = "/qna/adminQnaSearch.do";
			}
			else if(action.equals("/adminQnaListPage.do")){
				viewPage = "/qna/adminQnaListPage.do";
			}
			// ************************* <INFORM>
			else if(action.equals("/getInformList.do")){
				viewPage = "/qna/getInformQnaReply.do";
			}
			else if(action.equals("/messageUnread.do")) {
				viewPage = "/qna/messageUnread.do";
			}
			// ************************* <REVIEW & COMMENT>
			else if(action.equals("/reviewList.do")){
				viewPage = "/review/reviewList.do";
			}
			else if(action.equals("/reviewWriteForm.do")){
				viewPage = "/review/reviewWriteForm.do";
			}
			else if(action.equals("/reviewWrite.do")){
				viewPage = "/review/reviewWrite.do";
			}
			else if(action.equals("/reviewInfo.do")){
				viewPage = "/review/reviewInfo.do";
			}
			else if(action.equals("/reviewDelete.do")){
				viewPage = "/review/reviewDelete.do";
			}
			else if(action.equals("/reviewUpdate.do")){
				viewPage = "/review/reviewUpdate.do";
			}
			else if(action.equals("/commentWrite.do")){
				viewPage = "/recomment/commentWrite.do";
			}
			else if(action.equals("/commentDelete.do")){
				viewPage = "/recomment/commentDelete.do";
			}
			else if(action.equals("/commentModify.do")){
				viewPage = "/recomment/commentModify.do";
			}
			else if(action.equals("/commentList.do")){
				viewPage = "/recomment/commentList.do";
			}
			else if(action.equals("/commentListPaging.do")){
				viewPage = "/recomment/commentListPaging.do";
			}
			else if(action.equals("/mainReviewCommentSize.do")){
				viewPage = "/recomment/mainReviewCommentSize.do";
			}
			// ************************* <AIRPLANE>
			else if(action.equals("/airplaneSearch.do")){
				viewPage = "/airplane/airplaneSearch.do";
			}
			else if(action.equals("/airPlaneResearch.do")){
				viewPage = "/airplane/airPlaneResearch.do";
			}
			else if(action.equals("/airplaneList.do")){
				viewPage = "/airplaneView/airplaneList.jsp";
			}
			// ************************* <INIT>
			else if(action.equals("/mainInit.do")){
				viewPage = "/mainView/index.jsp";
			}
			else{
				viewPage = "/review/mainReviewList.do";
			}
		}
		catch(Exception e){
			System.out.println("MainController Error : " + e);
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}//doHandle() 끝
}// 컨트롤러 끝
