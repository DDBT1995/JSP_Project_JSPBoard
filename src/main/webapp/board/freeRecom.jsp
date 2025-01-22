<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<% 
	Logger logger = LogManager.getLogger("/board/freeView.jsp");
	HttpUtil.requestLogString(request,logger);
	String cookieUserId = CookieUtil.getValue(request,"USER_ID");	
	long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	long currentPage = HttpUtil.get(request, "currentPage", (long)1);
	
	
	User user = new User();
	UserDao userDao = new UserDao();
	user = userDao.userSelect(cookieUserId);
	
	logger.debug("freeBbsSeq0000000000000" + freeBbsSeq);
	
	FreeBbs board = new FreeBbs();
	FreeBbsDao boardDao = new FreeBbsDao();
	board = boardDao.freeBbsSelect(freeBbsSeq);
	
	logger.debug("board000000000" + board);
	
	String redirectUrl = "";
	String message = "";
	String icon = "";
	
	logger.debug("cookieUserId0000000000000000" + cookieUserId);
	logger.debug("진짜 잡는다 1");
	if(!StringUtil.isEmpty(cookieUserId))
	{	
		logger.debug("진짜 잡는다 2");
		if(board != null)
		{	
			logger.debug("진짜 잡는다 3");
			// 중복검사 후 반환값이 0이라면 
			if(boardDao.freeRecomCheck(user, board) <= 0)
			{	
				logger.debug("진짜 잡는다 4");
				// 추천수 증가하고 값이 true 라면??
				if(boardDao.freeBbsRecomCntPlus(freeBbsSeq))
				{	
					logger.debug("진짜 잡는다 5");
					if(boardDao.freeRecomInsert(user, board) > 0)
					{	
						if (request.getHeader("Referer").contains("freeView"))	
			            {	
							redirectUrl = "/board/freeView.jsp";
							message = "추천 및 중복 방지 완료";
							icon = "success";
			            }
						else
						{
							
							message = "추천 및 중복 방지 완료";
			             	redirectUrl = "/";
			             	icon = "success";
						}
					}
					else
					{	
						redirectUrl = "/board/freeView.jsp";
						message = "추천 중복 방지 중 오류 발생";
						icon = "error";
					}
				}
				else
				{	
					redirectUrl = "/board/freeView.jsp";
					message = "추천 수 증가 중 오류 발생";
					icon = "error";
				}
			}
			else
			{	
				if(boardDao.freeBbsRecomCntMinus(freeBbsSeq))
				{
					if(boardDao.freeRecomDelete(user, board) > 0)
					{
						// 중복 검사 후 반환값이 0 이상이라면 이미 추천 누른 상태이므로 추천 취소
						if (request.getHeader("Referer").contains("freeView"))	
			            {	
							redirectUrl = "/board/freeView.jsp";
							message = "추천 취소 완료";
							icon = "success";
			            }
						else
						{
							
							message = "추천 취소 완료";
			             	redirectUrl = "/";
			             	icon = "success";
						}
					}
				}
				else
				{
					redirectUrl = "/board/freeView.jsp";
					message = "추천 수 감소 중 오류 발생";
					icon = "error";
				}
			}
			
		}
		else
		{
			redirectUrl = "/board/freeList.jsp";
			message = "삭제된 게시물 입니다.";
			icon = "warning";
		}
	}
	else
	{
		redirectUrl = "/board/freeList.jsp";
		message = "추천은 로그인 후 가능합니다.";
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
		Swal.fire({
	        title: '<%=message%>',
	        icon: '<%=icon%>',
	        confirmButtonColor: '#3085d6',
	        confirmButtonText: '확인',
	     }).then(result => {
	        if 
	        (result.isConfirmed) {        
	        	document.freeRecomBbsForm.action = "<%=redirectUrl%>";
	    		document.freeRecomBbsForm.submit();
	        }
	  
	     });
	});
</script>
</head>
<body>
	<form name="freeRecomBbsForm" method="post">
		<input type="hidden" name="freeBbsSeq" value="<%=freeBbsSeq%>"/>
		<input type="hidden" name="currentPage" value="<%=currentPage%>"/>
	</form>
</body>
</html>