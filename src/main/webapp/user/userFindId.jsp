<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>

<script>
function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
$(document).ready(function(){
   
   $("#userName").focus;
   $("#btnFind").on("click",function(){
      if($.trim($("#userName").val()).length <= 0)
      {
         alert("사용자 이름을 입력해주세요");
         $("#userName").val("");
         $("#userName").focus;
         return;
      }
      
      
      if($.trim($("#userEmail").val()).length <= 0)
      {
         alert("사용자 이메일을 입력해주세요");
         $("#userEmail").val("");
         $("#userEmail").focus;
         return;
      }
      
      if(!fn_validateEmail($("#userEmail").val()))
      {
         alert("사용자 이메일 형식이 올바르지 않습니다.");
         $("#userEmail").focus;
         return;
      }
      
      document.findForm.submit();
      
   });
});
</script>

</head>
<body>
<%@ include file="/include/navigation.jsp"%>
<div class="container" style="max-width: 400px; background-color: #e8eaf6; border-radius: 10px; padding: 20px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);">
    <div class="row mt-5">
        <h1 class="text-center text-nowrap">아이디 찾기</h1>
    </div>
    <div class="row mt-4">
        <div class="col-12">
            <form id="findForm" name="findForm" method="post" action="/user/userFindIdProc.jsp">
                <div class="form-group mb-3">
                    <label for="userName" class="form-label">사용자 이름</label>
                    <input type="text" class="form-control" id="userName" name="userName" placeholder="사용자 이름" maxlength="15" required style="flex: 1;">
                </div>
                <br />
                 <div class="form-group mb-3">
                    <label for="userEmail" class="form-label">사용자 이메일</label>
                    <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="사용자 이메일" maxlength="30" required style="flex: 1;">
                </div>
                <br />
                <div class="d-flex justify-content-end mt-4">
                    <button type="button" id="btnFind" class="btn btn-outline-primary" style="background-color: #3f51b5;">찾기</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>