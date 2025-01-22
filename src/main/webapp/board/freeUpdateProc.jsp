<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>

<%
	Logger logger = LogManager.getLogger("/board/updateProc.jsp");
	HttpUtil.requestLogString(request, logger);	// logger 받아서 뿌려줌
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	String searchType = HttpUtil.get(request, "searchType", "");
	String searchValue = HttpUtil.get(request, "searchValue", "");
	long currentPage = HttpUtil.get(request, "currentPage", (long)0);
	
	
	String freeBbsTitle = HttpUtil.get(request,"freeBbsTitle");
	String freeBbsContent = HttpUtil.get(request,"freeBbsContent");
	
	String errorMessage = "";
	boolean bSuccess = false;
	
	logger.debug("cookieUserId0000000000000" + cookieUserId);
	logger.debug("freeBbsSeq00000000000000" + freeBbsSeq);
	logger.debug("searchType00000000" + searchType);
	logger.debug("searchValue000000000" + searchValue);
	logger.debug("currentPage0000000000" + currentPage);
	logger.debug("freeBbsTitle00000000" + freeBbsTitle);
	logger.debug("freeBbsContent00000000" + freeBbsContent);
	
	if(freeBbsSeq > 0 && !StringUtil.isEmpty(freeBbsTitle) && !StringUtil.isEmpty(freeBbsContent))
	{
		FreeBbsDao boardDao = new FreeBbsDao();
		FreeBbs board = boardDao.freeBbsSelect(freeBbsSeq);
		
		logger.debug("잡는다 진짜1");
		if(board != null)
		{		
			logger.debug("잡는다 진짜2");
			if(StringUtil.equals(cookieUserId, board.getUserId()))
			{	
				board.setFreeBbsTitle(freeBbsTitle);
				board.setFreeBbsContent(freeBbsContent);
				board.setFreeBbsSeq(freeBbsSeq);
			
				if(boardDao.freeBbsUpdate(board))
				{	
					
					bSuccess = true;
					logger.debug("잡는다 진짜3");
				}
				else
				{	
					errorMessage = "게시물 수정중 오류가 발생하였습니다.";
				}
				
			}
			else
			{
				errorMessage = "사용자 정보가 일치하지 않습니다.";
			}
		}
		else
		{
			errorMessage = "게시물이 존재 하지 않습니다.";	
		}
		
	}
	else
	{
		errorMessage = "게시물 수정 값이 올바르지 않습니다.";
	}
	
	
%>




<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

$(document).ready(function(){
<%	
logger.debug("잡는다 진짜5");
	if(bSuccess == true)
	{
logger.debug("잡는다 진짜6");
	
%>
	alert("게시물이 수정되었습니다.");
	document.freeBbsForm.action = "/board/freeView.jsp";
	document.freeBbsForm.submit();
	logger.debug("잡는다 진짜7");
<%
	}
	else
	{
%>
	alert("<%=errorMessage%>");
	location.href = "/board/freeView.jsp";
<%
	}
%>
});
</script>
</head>
<body>
	<form name="freeBbsForm" method="post">
		<input type="hidden" name="freeBbsSeq" value="<%=freeBbsSeq%>"/>
		<input type="hidden" name="searchType" value="<%=searchType%>"/>
		<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
		<input type="hidden" name="currentPage" value="<%=currentPage%>"/>
	</form>
</body>
</html>