package com.ode.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

// [ 占쏙옙청占쌍쇽옙 ] memverView
// 占싸깍옙占쏙옙 => (memberLogin.do) -> /login.jsp -> (memberLoginChk.do)
// 회占쏙옙占쏙옙占쏙옙 => (joinMember.do) -> /joinForm.jsp -> (addMember.do)
// 회占쏙옙占쏙옙占쏙옙 => (mypageInfo.do) -> /mypage.jsp  -> (memberModify.do) -> /memberMod.jsp  
// 회占쏙옙占쏙옙占쏙옙 => (mypageInfo.do) -> /mypage.jsp  -> (memberDelete.do) -> 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占싱듸옙
// 占쏙옙占쏙옙占쏙옙 占쏙옙占� 占쏙옙占쏙옙 => (adminAuthMemberDelete.do)

@WebServlet("/member/*")
public class MemberController extends HttpServlet {
	
	MemberVO memberVO;
	MemberService memberService;
	HttpSession session;
	String totalEmail;
	public MemberController(){
		memberService = new MemberService();
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
		
		session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String viewPage = "";
		String action  = request.getPathInfo();
		System.out.println("MemberController Action : " + action);
		
		try {
			if(action.equals("/adminSearch.do")){
				String name = request.getParameter("name");
				String result = memberService.getJSON(name);
				response.getWriter().write(result);
				response.getWriter().flush();
				response.getWriter().close();
				return;
			}
			else if(action.equals("/adminSearchPage.do")){
				viewPage = "/memberView/memberSearch.jsp";
			}
			else if(action.equals("/adminQnaListPage.do")){
				viewPage = "/memberView/qnaSearch.jsp";
			}
			else if(action.equals("/memberLogout.do")){
				session.invalidate();
				viewPage = "/main/mainInit.do";
			}
			else if(action.equals("/memberModify.do")){
				String email = request.getParameter("email");
				String pwd = request.getParameter("pwd");
				
				int result = memberService.memberModify(email,pwd);
				request.setAttribute("result" , result);
				viewPage = "/memberView/mypage.jsp";
			}
			else if(action.equals("/adminAuthMemberDelete.do")){
				String tel = request.getParameter("tel");
				int result = memberService.adminAuthMemberDelete(tel);
				if(result == 1) {
					session.setAttribute("messageType", "삭제 성공 Message");
					session.setAttribute("messageContent", "회원이 삭제되었습니다.");
				}else {
					session.setAttribute("messageType", "삭제 실패 Message");
					session.setAttribute("messageContent", "회원이 삭제되지 않았습니다.");
				}
				viewPage = "/memberView/memberSearch.jsp";
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);			
			dispatcher.forward(request, response);
			
		} 
		catch (Exception e) {
			System.out.println("MemberController Error : "+e);
			e.printStackTrace();
		}
	
	}//doHandle()
	//MAIN <-> MEMBER AREA
	public int emailDuplChk(String totalEmail){
		return memberService.emailDuplChk(totalEmail);
	}

	public int addMember(String name, String pwd, String email, String birth, String tel) {
		return memberService.addMember(name, pwd, email, birth, tel);
	}

	public Map<String, Object> memberLoginChk(String email, String pwd) {
		return memberService.memberLoginChk(email, pwd);
	}

	public String emailAuthNumSend(String totalEmail) {
		return memberService.emailAuthNumSend(totalEmail);
	}

	public MemberVO memberInfo(String name, String email) {
		return memberService.memberInfo(name, email);
	}


	public int rewritePwd(String email, String rewritePwd) {
		return memberService.rewritePwd(email, rewritePwd);
	}


	public int memberDelete(String email) {
		return memberService.memberDelete(email);
	}
	

	
}//
	
	
