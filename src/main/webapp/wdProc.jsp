<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@   page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.web.dao.UserDao"%>
<%@ page import="com.sist.web.model.User"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>

<%
   Logger logger = LogManager.getLogger("userProc_2.jsp");
   HttpUtil.requestLogString(request, logger);
   
   String msg = "";
   String redirectUrl = "";
   
   String userId = HttpUtil.get(request, "userId");
   String userPwd = HttpUtil.get(request, "userPwd");
   String userName = HttpUtil.get(request, "userName");
   String userEmail = HttpUtil.get(request, "userEmail");
   String cookieUserId = CookieUtil.getValue(request,"USER_ID");
   
   UserDao userDao = new UserDao();
   boolean boolCan = false;
   
   if(StringUtil.isEmpty(cookieUserId))   
   {   
      msg = "비정상적인 접속 감지";
      redirectUrl = "/";
   }
   else
   {   
      // 회원정보 탈퇴
      User user = userDao.userSelect(cookieUserId);
      
      if(user != null)
      {
         if(StringUtil.equals(user.getUserStatus(),"Y") && 
               StringUtil.equals(user.getUserId(), userId))
         {   
            logger.debug("userId ; " + userId);
            logger.debug("userPwd ; " + userPwd);
            logger.debug("userName ; " + userName);
            logger.debug("userEmail ; " + userEmail);
            if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
            {
               user.setUserId(userId);
               user.setUserStatus("N");
               logger.debug("userStatus ; " + user.getUserStatus());
               
               if(userDao.userCancel(userId))
               {
                  msg = "회원 탈퇴되었습니다..";
                  redirectUrl = "index.jsp";
               }
               else
               {
                  msg = "회원 탈퇴중 오류가 발생하였습니다.";
                  redirectUrl = "/user/userWithDraw.jsp";
               }
               
            }
            else
            {
               msg = "회원정보 중 값이 올바르지 않습니다.";
               redirectUrl = "/user/userWithDraw.jsp";
            }
         }
         else
         {
            CookieUtil.deleteCookie(request, response, "/", "USER_ID");
            msg = "정지된 사용자 입니다.";
            redirectUrl = "/";
         }
         
      }
      else
      {
         CookieUtil.deleteCookie(request, response, "/", "USER_ID");
         msg = "올바른 사용자가 아닙니다.";
         redirectUrl = "/";
      }
   }

%>




<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>

<title>Insert title here</title>
<script>
   $(document).ready(function(){
      alert("<%=msg%>");
      location.href = "<%= redirectUrl%>";
   });
</script>
</head>
<body>

</body>
</html>