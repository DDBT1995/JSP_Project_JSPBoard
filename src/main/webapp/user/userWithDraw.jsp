<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
   $("#btnWithDraw").on("click",function(){
      var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
      var emptCheck = /\s/g;

      
      if($.trim($("#userPwd1").val()).length <= 0)
      {
         alert("비밀번호 입력하세요");
         $("#userPwd1").val("");
         $("#userPwd2").focus();
         return;
      }
      
      if(emptCheck.test($("#userPwd1").val()))
      {
         alert("비밀번호는 공백을 포함할 수 없습니다.");
         $("#userPwd1").focus();
         return;
      }
      
      if(!idPwCheck.test($("#userPwd1").val()))
      {
         alert("비밀번호는 영문대소문자, 숫자로만 이루어진 4~12자리로만 입력가능합니다.");
         $("#userPwd1").focus();
         return;
      }
      
      if($("#userPwd1").val() != $("#userPwd2").val())
      {
         alert("비밀번호가 일치하지 않습니다.");
         $("#uesrPwd2").focus();
         return;
      }
      
      $("#userPwd").val($("#userPwd1").val());
      
      Swal.fire({
            title: '정말로 그렇게 하시겠습니까?',
            text: '다시 되돌릴 수 없습니다. 신중하세요.',
            icon: 'warning',
            
            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
            cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정
            
            reverseButtons: true, // 버튼 순서 거꾸로
            
         }).then(result => {
            // 만약 Promise리턴을 받으면,
            if 
            (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
            
               document.wdForm.submit();
            }
      
         });
      
      
   
      
   });
});
</script>
</head>
<body>
   <%@ include file="/include/navigation.jsp"%>
<div class="container" style="max-width: 400px; background-color: #e8eaf6; border-radius: 10px; padding: 20px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);">
    <div class="row mt-5">
        <h1 class="text-center text-nowrap">회원탈퇴</h1>
    </div>
    <div class="row mt-4">
        <div class="col-12">
            <form id="wdForm" name="wdForm" method="post" action="/wdProc.jsp">
                <div class="form-group mb-3">
                    <label for="userId" class="form-label">사용자 아이디</label>                    
                    <input type="text" class="form-control me-3" id="userId" name="userId" placeholder="사용자 아이디" maxlength="12" required style="flex: 1;">                     
                </div>
                <div class="form-group mb-3">
                    <label for="userPwd1" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="userPwd1" name="userPwd1" placeholder="비밀번호" maxlength="12" required style="flex: 1;">
                   <span class="pwdText1"></span>
                </div>
                <div class="form-group mb-3">
                    <label for="userPwd2" class="form-label">비밀번호 확인</label>
                    <input type="password" class="form-control" id="userPwd2" name="userPwd2" placeholder="비밀번호 확인" maxlength="12" required style="flex: 1;">
                   <span class="pwdText2"></span>
                </div>
                <input type="hidden" id="userPwd" name="userPwd" value="">
                <div class="d-flex justify-content-end mt-4">
                <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                    <button type="button" id="btnWithDraw" class="btn btn-outline-primary" style="background-color: #3f51b5;">탈퇴</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>