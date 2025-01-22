<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>
<%@ page import="java.util.List"%>
<%@ page import="com.sist.web.model.FreeCom" %>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="com.sist.web.dao.UserDao" %>


<%
Logger logger = LogManager.getLogger("freeComWriteAjax.jsp");
HttpUtil.requestLogString(request, logger);

String userId = HttpUtil.get(request, "userId");
long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
String commentText = HttpUtil.get(request, "commentText");

User user = new User();
UserDao userDao = new UserDao();
user = userDao.userSelect(userId);
FreeCom freeCom = new FreeCom();

logger.debug("commentText0000000000000" + commentText);

if (StringUtil.isEmpty(userId)) 
{
	response.getWriter().write("{\"flag\":0}");
} 
else if (!StringUtil.isEmpty(userId))
{
	FreeBbsDao boardDao = new FreeBbsDao();
	FreeBbs board = boardDao.freeBbsSelect(freeBbsSeq);
	freeCom.setFreeComContent(commentText);
	
	if (boardDao.freeComInsert(freeCom, user, board) > 0)
	{
		response.getWriter().write("{\"flag\":1}");
	} 
	else
	{
		response.getWriter().write("{\"flag\":2}");
	}
} 
else
{
	response.getWriter().write("{\"flag\":-1}");
}
%>