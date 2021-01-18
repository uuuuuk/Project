<%@page import="web.mail.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String from = request.getParameter("email");
MailSend ms = new MailSend();
ms.mailSend(from); 
 
out.println("메일을 발송하였습니다.");

%>
<br> <input type="button" value="닫기" onclick="window.close()"/>

