<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="org.apache.logging.log4j.LogManager"%>   
<%@ page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>

<%
   Logger logger = LogManager.getLogger("userUpdateForm.jsp");
   HttpUtil.requestLogString(request, logger);
   
   String userId = CookieUtil.getValue(request, "USER_ID");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>
var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;   //아이디,비밀번호 정규표현식
var emptCheck = /\s/g;               //공백체크 정규표현식

$(document).ready(function(){
	  
   
   $("#btnUpdate").on("click",function(){
      
      if($.trim($("#userPwd1").val()).length <= 0)
      {
         $(".pwdText1").text("비밀번호를 입력하세요.");
         $(".pwdText1").css('color', 'red');
         $("#userPwd1").val("");
         $("#userPwd1").focus();
         return;   
      }
      if(emptCheck.test($("#userPwd1").val()))
      {
         $(".pwdText1").text("사용자 비밀번호에는 공백을 포함할수 없습니다.");
         $(".pwdText1").css('color', 'red');
         $("#userPwd1").val("");
         $("#userPwd1").focus();
         return;   
      }
      if(!idPwCheck.test($("#userPwd1").val()))
      {
         $(".pwdText1").text("비밀번호는 영문 대소문자와 숫자로 4~12자로 입력가능합니다.");
         $(".pwdText1").css('color', 'red');
         $("#userPwd1").val("");
         $("#userPwd1").focus();
         return;
      }
      else
	  {
    	  $(".pwdText1").text("사용 가능한 비밀번호 입니다.");
	      $(".pwdText1").css('color', 'blue');
	  }	     
	      
      
      $("#userPwd").val($("#userPwd1").val());
      
      if($.trim($("#userEmail").val()).length <= 0)
		{
    	    $(".emailText").text("사용자 이메일을 입력하세요.");
	        $(".emailText").css('color', 'red');
			$("#userEmail").val("");
			$("#userEmail").focus();
			return;
		}
		
		if(!fn_validateEmail($("#userEmail").val()))
		{
			$(".emailText").text("사용자 이메일 형식이 올바르지 않습니다. 다시입력하세요.");
	        $(".emailText").css('color', 'red');
			$("#userEmail").focus();
		}
		else
		{
			$(".emailText").text("사용 가능한 이메일 입니다.");
	        $(".emailText").css('color', 'blue');
		}
		
		document.upDateForm.submit();
   });
   
   $("#userPwd1, #userPwd2, #userEmail").on("keyup", checkPassword);
});
	
//이메일 정규표현식
 
function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

function checkPassword() {
    var password = $("#userPwd1").val(); // 비밀번호
    var confirmPassword = $("#userPwd2").val(); // 확인 비밀번호

    console.log("Password 1:", password); // 디버깅 로그
    console.log("Password 2:", confirmPassword); // 디버깅 로그

    // 공백 체크
      if($.trim($("#userPwd1").val()).length > 0)
      {
		   if (emptCheck.test(password)) {
		       $(".pwdText1").text("사용자 비밀번호에는 공백을 포함할 수 없습니다.");
		       $(".pwdText1").css('color', 'red');
		       return; // 공백이 포함되면 함수를 종료
		   } else if($.trim($("#userPwd1").val()).length <= 0){
			   
		       $(".pwdText1").text("아이디를 입력해주세요."); // 공백 체크 통과시 메시지 초기화
		       $(".pwdText1").css('color', 'red');
			      
		   } else {
			   $(".pwdText1").text("사용 가능한 비밀번호 입니다."); // 공백 체크 통과시 메시지 초기화
		       $(".pwdText1").css('color', 'blue');
			}
      }

    // 비밀번호와 확인 비밀번호가 모두 입력된 경우에만 비교
    if ($.trim(password).length > 0 && $.trim(confirmPassword).length > 0) {
        if (password === confirmPassword) {
            $(".pwdText2").text("비밀번호가 일치합니다.").css('color', 'blue');
        } else {
            $(".pwdText2").text("비밀번호가 일치하지 않습니다.").css('color', 'red');
        }
    } else {
        // 비밀번호 입력란이 비어 있을 때 메시지 초기화
        $(".pwdText2").text("");
    }
    
    $.ajax({
        type: "POST",
        url: "/user/userEmailCheckAjax.jsp",
        data: {
                 userEmail: $("#userEmail").val() 
              },
        datatype: "JSON", 
        success: function(obj) {
           var data = JSON.parse(obj);

           if(data.flag == 0)
           {
              $(".emailText").text("");
           }
           else if (data.flag == 1)
            {
               $(".emailText").text("사용 가능한 이메일입니다.").css('color', 'blue');
            }
            else if (data.flag == 2)
            {
               $(".emailText").text("이미 사용 중인 이메일입니다.").css('color', 'red');
                $("#userEmail").focus();
            }
            else
            {
               $(".emailText").text("이메일 값을 확인하세요.").css('color', 'red');
                $("#userEmail").focus();
            }
        },
        error: function(xhr, status, error)
        {
            $(".emailText").text("이메일 중복 체크 오류").css('color', 'red');
        }
    });
}


// 이벤트 리스너 등록


</script>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>

<div class="container">
    <div class="row mt-5">
       <h1>회원정보수정</h1>
    </div>
    <div class="row mt-2">
        <div class="col-12">
         <form name="upDateForm" id="upDateForm" action="/user/userProc.jsp" method="post">
                <div class="form-group fs-4">
                    <label for="username">사용자 아이디</label>
                   <!-- 쿠키아이디나 유저아이디 둘다 사용가능 -->
                </div>
                <br />
                <div class="form-group">
                    <label for="username">비밀번호</label>
                    <input type="password" class="form-control" id="userPwd1" name="userPwd1" value="" placeholder="비밀번호" maxlength="12" />
                     <span class="pwdText1"></span>
                </div>
                <br />
                <div class="form-group">
                    <label for="username">비밀번호 확인</label>
                    <input type="password" class="form-control" id="userPwd2" name="userPwd2" value="" placeholder="비밀번호 확인" maxlength="12" />
                    <span class="pwdText2"></span>
                </div>
                <br />
                <div class="form-group">
                    <label for="username">사용자 이름</label>
                    <input type="text" class="form-control" id="userName" name="userName" value="" placeholder="사용자 이름" maxlength="15" />
                </div>
                <br />
                <div class="form-group">
                    <label for="username">사용자 이메일</label>
                    <input type="text" class="form-control" id="userEmail" name="userEmail" value="" placeholder="사용자 이메일" maxlength="30" />
                     <span class="emailText"></span>
                </div>
                <br />
                <div class="form-group">
                    <label for="username">사용자 생년월일</label>
                    <input type="date" class="form-control" id="userBirthDay" name="userBirthDay" value="" placeholder="사용자 생년월일" maxlength="30" />
                </div>
                <input type="hidden" id="userId" name="userId" value="<%=userId%>" />
            <input type="hidden" id="userPwd" name="userPwd" value="히든비밀번호" />
            <div class="d-flex justify-content-end mt-4">
                <button type="button" id="btnUpdate" class="btn btn-outline-primary" style="background-color: #3f51b5;">수정</button>
                </div>
         </form>
        </div>
    </div>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>