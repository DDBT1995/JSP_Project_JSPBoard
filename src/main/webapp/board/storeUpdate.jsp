<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<script>

</script>
</head>
<body>
   
<%@ include file="/include/navigation.jsp" %>

<div class="container">
   <br />
   <h2>맛집 게시물 수정</h2>





	<form name="updateForm" id="updateForm" action="/board/storeUpdateProc.jsp" method="post">
      <input type="text" name="bbsName" id="bbsName" maxlength="20" value="" style="ime-mode:active;"class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="bbsEmail" id="bbsEmail" maxlength="30" value=""  style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />


   <!-- StoreUpdateProc.jsp와 storerUpdateProc.jsp 두 가지를 모두 반영 -->
   <form name="updateForm" id="updateForm" action="/board/StoreUpdateProc.jsp" method="post">
   <form name="updateForm" id="updateForm" action="/board/storerUpdateProc.jsp" method="post">

      <input type="text" name="bbsName" id="bbsName" maxlength="20" value="" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="bbsEmail" id="bbsEmail" maxlength="30" value="" style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />




      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
      </div>
      <input type="hidden" name="bbsSeq" value=""/>
      <input type="hidden" name="searchType" value=""/>
      <input type="hidden" name="searchValue" value=""/>
      <input type="hidden" name="curPage" value=""/>
   </form>
   
   <div class="form-group row">
      <div class="col-sm-12">
         <div class="d-flex justify-content-end mt-4">
            <button type="button" id="btnUpdate" class="btn btn-outline-primary" title="수정"><i class="fa-sharp-duotone fa-solid fa-file-pen"></i> 수정</button>
            <button type="button" id="btnList" class="btn btn-outline-primary" style="position: relative; left: 10px;" title="리스트"><i class="fa-sharp-duotone fa-solid fa-list"></i> 리스트</button>
         </div>
      </div>
   </div>
</div>

<form name="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value=""/>
   <input type="hidden" name="searchType" value=""/>
   <input type="hidden" name="searchValue" value=""/>
   <input type="hidden" name="curPage" value=""/>
</form>

<%@ include file="/include/footer.jsp" %>
</body>
</html>