<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@ page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.web.dao.UserDao"%>
<%@ page import="com.sist.web.model.User"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>

<%
Logger logger = LogManager.getLogger("userEmailCheckAjax.jsp");
HttpUtil.requestLogString(request, logger);

String userEmail = HttpUtil.get(request, "userEmail");
if (StringUtil.isEmpty(userEmail)) {
	response.getWriter().write("{\"flag\":0}");
} else if (!StringUtil.isEmpty(userEmail)) {
	UserDao userDao = new UserDao();
	if (!userDao.userEmailIsDuplicated(userEmail)) {
		response.getWriter().write("{\"flag\":1}");
	} else {
		response.getWriter().write("{\"flag\":2}");
	}
} else {
	response.getWriter().write("{\"flag\":-1}");
}
%>