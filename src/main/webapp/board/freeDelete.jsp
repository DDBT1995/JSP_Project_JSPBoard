<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>

<%
	Logger logger = LogManager.getLogger("/board/delete.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	
	String errorMessage = "";
	boolean bSuccess = false;
	if(freeBbsSeq > 0)
	{
		FreeBbsDao boardDao = new FreeBbsDao();
		FreeBbs board = boardDao.freeBbsSelect(freeBbsSeq);
		
		if(board != null)
		{
			if(StringUtil.equals(cookieUserId, board.getUserId()))
			{
				if(boardDao.freeBbsDelete(freeBbsSeq))
				{
					bSuccess = true;
				}
				else
				{
					errorMessage = "게시물 삭제 중 오류가 발생하였습니다.";
				}
			}
			else
			{
				errorMessage = "로그인 사용자의 게시물이 아닙니다.";
			}
		}
		else
		{
			errorMessage = "해당 게시글이 존재하지 않습니다.";
		}
	}
	else 
	{
		errorMessage = "게시물 번호가 올바르지 않습니다.";
	}
	
%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
$(document).ready(function(){
<%
	if(bSuccess == true)
	{
%>
		alert("게시물이 삭제 되었습니다.");
<%
	}
	else
	{
%>
		alert("<%=errorMessage%>");
<%
	}
%>
	location.href = "/board/freeList.jsp";
});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>