<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>
<script>

$(document).ready(function(){
   $("#userId").focus();
   
   var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;   //아이디,비밀번호 정규표현식
   var emptCheck = /\s/g;               	//공백체크 정규표현식
   
   $("#btnUserId").click(function(){
   
      if($.trim($("#userId").val()).length <= 0)
      {
         $(".idText").text("사용자 아이디를 입력하세요.");
         $(".idText").css('color', 'red');
         $("#userId").val("");
         $("#userId").focus();
         return;
      }
      if(emptCheck.test($("#userId").val()))
      {
         $(".idText").text("사용자 아이디는 공백을 포함할수 없습니다.");
         $(".idText").css('color', 'red');
         $("#userId").val("");
         $("#userId").focus();
         return;
      }
      if(!idPwCheck.test($("#userId").val()))
      {
         $(".idText").html("사용자 아이디는 4~12자 영문 대소문자와 숫자로만 <br/>입력가능합니다.");
         $(".idText").css('color', 'red');
         $("#userId").val("");
         $("#userId").focus();
         return;
      }
      
      $.ajax({
          type: "POST",
          url: "/user/userIdCheckAjax.jsp",
          data: {
          			userId: $("#userId").val() 
          		},
          datatype: "JSON", 
          success: function(obj) {
        	  var data = JSON.parse(obj);
 
              if (data.flag == 0)
              {
            	  $(".idText").text("사용 가능한 아이디입니다.").css('color', 'blue');
              }
              else if (data.flag == 1)
              {
            	  $(".idText").text("이미 사용 중인 아이디입니다.").css('color', 'red');
                  $("#userId").focus();
              }
              else
              {
            	  $(".idText").text("아이디 값을 확인하세요.").css('color', 'red');
                  $("#userId").focus();
              }
          },
          error: function(xhr, status, error)
          {
              $(".idText").text("아이디 중복 체크 오류").css('color', 'red');
          }
      });
   });
   
   $('#userPwd1').on('input', function() {
       var userPwd1 = $("#userPwd1").val();
       var pwMessage = $('.pwdText1');

       // 메시지 초기화
       pwMessage.html('');
       
       var valid = true;
		
       if($.trim(userPwd1).length <= 0) {
    	   pwMessage.append('<p style="color: red;">비밀번호를 입력하세요.</p>');
           valid = false;
       }
       //공백 검사
       else if(emptCheck.test(userPwd1)) {
    	   pwMessage.append('<p style="color: red;">사용자 비밀번호에는 공백을 포함할수 없습니다.</p>');
           valid = false;
       }
       // 형식 검사
       else if (!idPwCheck.test(userPwd1)) {
    	   pwMessage.append('<p style="color: red;">비밀번호는 영문 대소문자와 숫자로 4~12자로만 <br/>입력가능합니다.</p>');
           valid = false;
       }
      
       // 모든 조건을 충족할 경우
       if (valid){
    	   pwMessage.append('<p style="color: blue;">비밀번호 형식이 올바릅니다.</p>');	// 성공 메시지
       }
   });
   
   $('#userPwd2').on('input', function() {
	   var cpPwMessage = $(".pwdText2");
	   cpPwMessage.empty(); // 기존 메시지 지우기

	   if($("#userPwd1").val() !== $("#userPwd2").val()) {
		   cpPwMessage.append('<p style="color: red;">비밀번호가 일치하지 않습니다.</p>');
	   } else if ($("#userPwd1").val() !== "") {
		   cpPwMessage.append('<p style="color: blue;">비밀번호가 일치하였습니다.</p>');
	   }
	});
   
   
   
   $('#userName').on('input', function() {
	   var nameMessage = $(".nameText");
	   nameMessage.empty();
	   
	   if($.trim($("#userName").val()).length <= 0) {
		   nameMessage.append('<p style="color: red;">사용자 이름을 입력하세요.</p>');
	   }
   });
   
   $('#userEmail').on('input', function() {
	   var emailMessage = $(".emailText");
	   emailMessage.empty();
	   
	   if($.trim($("#userEmail").val()).length <= 0) {
		   emailMessage.append('<p style="color: red;">사용자 이메일을 입력하세요.</p>');
	   }
	   else if(!fn_validateEmail($("#userEmail").val())) {
		   emailMessage.append('<p style="color: red;">사용자 이메일 형식이 올바르지 않습니다. <br/>다시입력하세요.</p>');
	   }
	   else {
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
   });

   
   $('#userBirthDay').on('input', function() {
	   var BDMessage = $(".birthDayText");
	   BDMessage.empty();
	   
	   if($.trim($("#userBirthDay").val()).length <= 0) {
		   BDMessage.append('<p style="color: red;">사용자 생년월일을 입력하세요.</p>');
	   }
   });
   
   
   $("#btnReg").on("click",function(){
	   $("#userPwd").val($("#userPwd1").val());
	   
	  if ($(".idText").text() === "사용 가능한 아이디입니다." && $(".emailText").text() === "사용 가능한 이메일입니다."){
		  document.regForm.submit();
	  }
	  else if ($(".idText").text() != "사용 가능한 아이디입니다."){
				Swal.fire({
			        title: '아이디 중복체크후 진행해주세요.',
			        icon: 'warning',
			        showCancelButton: true,
			        showConfirmButton: false,
			        cancelButtonColor: '#3085d6',
			        cancelButtonText: '아이디 중복체크 하러가기'
			     })
	  }
	  else if($(".emailText").text() != "사용 가능한 이메일입니다."){
		  Swal.fire({
		        title: '다른 이메일을 입력해주세요.',
		        icon: 'warning',
		        showCancelButton: true,
		        showConfirmButton: false,
		        cancelButtonColor: '#3085d6',
		        cancelButtonText: '이메일 췍<'
		     })
	  }
	  
   });
});

function fn_validateEmail(value)	//이메일 정규표현식
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

</script>
</head>
<body>
	<%@ include file="/include/navigation.jsp"%>
	<div class="container"
		style="max-width: 400px; background-color: #e8eaf6; border-radius: 10px; padding: 20px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);">
		<div class="row mt-5">
			<h1 class="text-center text-nowrap">회원가입</h1>
		</div>
		<div class="row mt-4">
			<div class="col-12">
				<form id="regForm" name="regForm" method="post"
					action="/user/userProc.jsp">
					<div class="form-group mb-3">
						<label for="userId" class="form-label">사용자 아이디</label>
						<div class="d-flex">
							<input type="text" class="form-control me-3" id="userId"
								name="userId" placeholder="사용자 아이디" maxlength="12" required
								style="flex: 1;">
							<button type="button" id="btnUserId"
								class="btn btn-outline-primary"
								style="background-color: #3f51b5;">중복 검사</button>
						</div>
						<span class="idText"></span>
					</div>
					<div class="form-group mb-3">
						<label for="userPwd1" class="form-label">비밀번호</label> <input
							type="password" class="form-control" id="userPwd1"
							name="userPwd1" placeholder="비밀번호" maxlength="12" required
							style="flex: 1;"> <span class="pwdText1"></span>
					</div>
					<div class="form-group mb-3">
						<label for="userPwd2" class="form-label">비밀번호 확인</label> <input
							type="password" class="form-control" id="userPwd2"
							name="userPwd2" placeholder="비밀번호 확인" maxlength="12" required
							style="flex: 1;"> <span class="pwdText2"></span>
					</div>
					<div class="form-group mb-3">
						<label for="userName" class="form-label">사용자 이름</label> <input
							type="text" class="form-control" id="userName" name="userName"
							placeholder="사용자 이름" maxlength="15" required style="flex: 1;">
						<span class="nameText"></span>
					</div>
					<br />
					<div class="form-group mb-3">
						<label for="userEmail" class="form-label">사용자 이메일</label> 
							<input type="email" class="form-control" id="userEmail" name="userEmail"
								placeholder="사용자 이메일" maxlength="30" required style="flex: 1;">
						<span class="emailText"></span>
					</div>
					<br />
					<div class="form-group mb-3">
						<label for="userBirthDay" class="form-label">사용자 생년월일</label> <input
							type="date" class="form-control" id="userBirthDay"
							name="userBirthDay" required style="flex: 1;"> <span
							class="birthDayText"></span>
					</div>
					<br /> <input type="hidden" id="userPwd" name="userPwd" value="">
					<div class="d-flex justify-content-end mt-4">
						<button type="button" id="btnReg" class="btn btn-outline-primary"
							style="background-color: #3f51b5;">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>