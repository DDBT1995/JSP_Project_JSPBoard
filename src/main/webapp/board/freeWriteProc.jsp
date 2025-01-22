<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>
<%
	Logger logger = LogManager.getLogger("/board/writeProc.jsp");
	HttpUtil.requestLogString(request, logger);
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	boolean bSuccess = false;
	String errorMessage = "";
	String icon = "";
	
	String freeBbsTitle = HttpUtil.get(request, "freeBbsTitle", "");
	String freeBbsContent = HttpUtil.get(request, "freeBbsContent", "");
	
	if(!StringUtil.isEmpty(freeBbsContent) && !StringUtil.isEmpty(freeBbsContent))
	{
		// 게시물 등록
		FreeBbs board = new FreeBbs();
		FreeBbsDao boardDao = new FreeBbsDao();
		
		board.setUserId(cookieUserId);
		board.setFreeBbsTitle(freeBbsTitle);
		board.setFreeBbsContent(freeBbsContent);
		
		if(boardDao.freeBbsInsert(board))
		{
			bSuccess = true;
			icon = "success";
		}
		else
		{
			errorMessage = "로그인 후 게시물 등록 가능합니다.";
			icon = "warning";
		}
	}
	else
	{
		errorMessage = "게시물 등록시 필요한 값이 올바르지 않습니다.";
		icon = "warning";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/include/header.jsp" %>
<script>
	$(document).ready(function(){
<%
	if(bSuccess == true)
	{
%>
		// 성곰시
		Swal.fire({
        title: '"게시물이 등록 되었습니다."',
        icon: '<%=icon%>',
        confirmButtonColor: '#3085d6',
        confirmButtonText: '확인',
     }).then(result => {
        if 
        (result.isConfirmed) {        
        	location.href = "/board/freeList.jsp";
        }
  
     });
<%
	}
	else
	{
%>
		
		// 실패시
		Swal.fire({
        title: '<%=errorMessage%>',
        icon: '<%=icon%>',
        confirmButtonColor: '#3085d6',
        confirmButtonText: '확인',
     }).then(result => {
        if 
        (result.isConfirmed) {        
        	location.href = "/board/freeWrite.jsp";
        }
  
     });

<%
	}
%>
	});
</script>
</head>

<body>

</body>
</html>