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
	Logger logger = LogManager.getLogger("userProc.jsp");
	HttpUtil.requestLogString(request, logger);

	String msg = "";
	String redirectUrl = "";
	String icon = "";
	
	String userId = HttpUtil.get(request, "userId");
	String userPwd = HttpUtil.get(request, "userPwd");
	String userName = HttpUtil.get(request, "userName");
	String userEmail = HttpUtil.get(request, "userEmail");
	String userBirthday = HttpUtil.get(request, "userBirthDay");
	
	String userBirthDay = userBirthday.replace("-", "");
	
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	UserDao userDao = new UserDao();
	
	if(StringUtil.isEmpty(cookieUserId))
	{	//회원가입
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) &&
				!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) &&
				!StringUtil.isEmpty(userBirthDay))
		{
			//회원가입
			User user = new User();
			
			user.setUserId(userId);
			user.setUserPwd(userPwd);
			user.setUserName(userName);
			user.setUserEmail(userEmail);
			user.setUserBirthday(userBirthDay);
			user.setUserStatus("Y");
			
			if(userDao.userInsert(user))
			{
				msg = "회원가입이 완료되었습니다.";
				redirectUrl = "/index.jsp";
				icon = "success";
			}
			else
			{
				msg = "회원가입 중 오류가 발생하였습니다.";
				redirectUrl = "/user/userRegForm.jsp";
				icon = "warning";
			}
			
		}
		else
		{
			msg = "회원가입정보가 올바르지 않습니다.";
			redirectUrl = "/user/userRegForm.jsp";
			icon = "warning";
		}
	}
	else
	{	//회원정보 수정
		User user = userDao.userSelect(cookieUserId);
		
		if(user != null)
		{
			if(StringUtil.equals(user.getUserStatus(), "Y") &&
					StringUtil.equals(user.getUserId(), userId))
			{
				if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) &&
						!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) &&
						!StringUtil.isEmpty(userBirthDay))
				{
					user.setUserId(userId);
					user.setUserPwd(userPwd);
					user.setUserName(userName);
					user.setUserEmail(userEmail);
					user.setUserBirthday(userBirthDay);
					
					if(userDao.userUpdate(user))	//업데이트 껀수
					{
						msg = "회원정보가 수정 되었습니다.";
						redirectUrl = "/user/userUpdateForm.jsp";
						icon = "success";
					}
					else
					{
						msg = "회원정보 수정 중 오류가 발생하였습니다.";
						redirectUrl = "/user/userUpdateForm.jsp";
						icon = "warning";
					}
				}
				else
				{
					msg = "회원정보 중 값이 올바르지 않습니다.";
					redirectUrl = "/user/userUpdateForm.jsp";
					icon = "warning";
				}
			}
			else
			{
				CookieUtil.deleteCookie(request, response, "/", "USER_ID");
				msg = "정지된 사용자 입니다.";
				redirectUrl = "/";
				icon = "error";
			}
		}
		else
		{
			CookieUtil.deleteCookie(request, response, "/", "USER_ID");
			msg = "올바른 사용자가 아닙니다.";
			redirectUrl = "/";
			icon = "warning";
		} 
	}
%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>

<script>
$(document).ready(function(){
	Swal.fire({
        title: '<%=msg%>',
        icon: '<%=icon%>',
        confirmButtonColor: '#3085d6',
        confirmButtonText: '확인',
     }).then(result => {
        if 
        (result.isConfirmed) {        
        	location.href = "<%=redirectUrl%>";
        }
  
     });
});
</script>
</head>
<body>

</body>
</html>

