<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>
<br />
<div class="container">
   <!-- 음식점 게시물 쓰기와 맛집 게시물 쓰기 둘 다 포함 -->
   <h2>음식점 게시물 쓰기</h2>

   <form name="writeForm" id="writeForm" action="/board/freeWriteProc.jsp" method="post">
      <input type="text" name="bbsName" id="bbsName" maxlength="20" value="이름" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="bbsEmail" id="bbsEmail" maxlength="30" value="이메일" style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />
      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
      </div>

      <div class="form-group row">
         <div class="col-sm-12">
            <div class="d-flex justify-content-end mt-4">
               <button type="button" id="btnWrite" class="btn btn-outline-primary me-2" title="저장">저장</button>
               <button type="button" id="btnList" class="btn btn-outline-primary" title="리스트">리스트</button>
            </div>
         </div>
      </div>
   </form>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>