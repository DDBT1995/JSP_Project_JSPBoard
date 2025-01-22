<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@   page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.web.dao.UserDao"%>
<%@ page import="com.sist.web.model.User"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>

<%
   Logger logger = LogManager.getLogger("findProd.jsp");
   
   String userId = HttpUtil.get(request, "userId");
   String userName = HttpUtil.get(request, "userName");
   String userEmail = HttpUtil.get(request, "userEmail");
   String icon = "";
   
   String msg = "";
   String redirectUrl = "/user/userFindPw.jsp";
   
   User user = null;
   UserDao userDao = new UserDao();

 
   logger.debug("userId : " + userId);
   logger.debug("userName : " + userName);
   logger.debug("userEmail : " + userEmail);
   
   if(!userId.trim().isEmpty() && !userName.trim().isEmpty() && !userEmail.trim().isEmpty())
   {
	   if(userDao.userPwdSearch(userName, userEmail, userId))
	   {	
		   user = userDao.userSelect(userId);
		   
		   if(user != null)
		     {
		        if(user.getUserStatus().equals("Y"))
		        {   
		           msg = "비밀번호를 찾았습니다. 비밀번호 : " + user.getUserPwd();
		           redirectUrl = "/index.jsp";
		           icon = "success";
		        }
		        else
		        {
		           msg = "정지된 사용자 입니다.";
		           redirectUrl = "/user/userFindPw.jsp";
		           icon = "warning";
		        }
		     }
		     else
		     {
		    	 msg = "DB상 오류 발생!!.";
			        redirectUrl = "/user/userFindPw.jsp";
			        icon = "error";
		     }
	   }
	   else
	   {
		   msg = "아이디,이름,이메일이 일치하는 비밀번호가 없습니다.";
	        redirectUrl = "/user/userFindPw.jsp";
	        icon = "warning";
	   }
   }
   else
   {
 	  msg = "아이디,이름,이메일이 정보가 없습니다..";
       redirectUrl = "/user/userFindPw.jsp";
       icon = "warning";
   }
%>
   
   
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
if (redirectUrl.equals("/index.jsp")) {
	session.setAttribute("idSchYn", "2");
	}
%>
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