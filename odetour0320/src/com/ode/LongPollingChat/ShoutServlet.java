package com.ode.LongPollingChat;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.AsyncContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/shoutServlet"}, asyncSupported=true)
public class ShoutServlet extends HttpServlet {
    private List<AsyncContext> contexts = new LinkedList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        asyncContext.setTimeout(10 * 60 * 1000);
        contexts.add(asyncContext);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html; charset=utf-8");
        List<AsyncContext> asyncContexts = new ArrayList<>(this.contexts);
    	
    	this.contexts.clear();
        String name = request.getParameter("name");
        String message= request.getParameter("message");
    	
        String htmlMessage = "<p><i class='far fa-user mr-1'></i>" + "<span style='color:#000067;'>" + name + "</span>" + "<br/>" + message + "</p>";
        ServletContext sc = request.getServletContext();
        if (sc.getAttribute("message") == null) {
        	
            sc.setAttribute("message", htmlMessage);
        } else {
            String currentMessages = (String) sc.getAttribute("message");
            
            sc.setAttribute("message", htmlMessage + currentMessages);
        }
        for (AsyncContext asyncContext : asyncContexts) {
            try (PrintWriter writer = asyncContext.getResponse().getWriter()) {
                writer.println(htmlMessage);
                writer.flush();
                asyncContext.complete();
            } catch (Exception ex) {
            	ex.printStackTrace();
            }
        }
       return;
       //response.sendRedirect("/LongChatView/LongChat.jsp");

    }
    
    
    
    
    
    
    
    
}