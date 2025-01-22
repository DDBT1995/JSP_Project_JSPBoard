<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@   page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.web.dao.UserDao"%>
<%@ page import="com.sist.web.model.User"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>

<%
   Logger logger = LogManager.getLogger("findIdProd.jsp");
   
   String userName = HttpUtil.get(request, "userName");
   String userEmail = HttpUtil.get(request, "userEmail");
   String icon = "";
   String msg = "";
   String redirectUrl = "/user/userFindId.jsp";
   
   User user = null;
   UserDao userDao = new UserDao();
   String userId = null;
   
   userId = userDao.userIdSearch(userName, userEmail);
   
   

   logger.debug("userName : " + userName);
   logger.debug("userEmail : " + userEmail);
   logger.debug("userId : " + userId);
   
   if(userId != null)
   {   
      user = userDao.userSelect(userId);
      if(user != null)
      {
         if(user.getUserStatus().equals("Y"))
         {   
        	 msg = "아이디를 찾았습니다. 아이디 : " + user.getUserId();
 	         redirectUrl = "/index.jsp";
 	       	 icon = "success";
         }
         else
         {
        		  msg = "탈퇴한 사용자 입니다.";
                  redirectUrl = "/user/userFindId.jsp";
                  icon = "warning";
                  
         }
      }
      else
      {
         msg = "DB에서 문제가 발생하였습니다.";
         redirectUrl = "/user/userFindId.jsp";
         icon = "error";
      }
   }
   else
   {
      msg = "이름,이메일이 일치하는 아이디가 없습니다.";
      redirectUrl = "/user/userFindId.jsp"; 
	  icon = "warning";
   }
%>
   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/include/header.jsp" %>
<title>Insert title here</title>
<%
if (redirectUrl.equals("/index.jsp")) {
	session.setAttribute("idSchYn", "1");
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