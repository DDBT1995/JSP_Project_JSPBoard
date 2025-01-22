<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>

<%
	Logger logger = LogManager.getLogger("/board/upadate.jsp");
	HttpUtil.requestLogString(request, logger);
	
	long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	String searchType = HttpUtil.get(request, "searchType", "");
	String searchValue = HttpUtil.get(request, "searchValue", "");
	long currentPage = HttpUtil.get(request, "currentPage", (long)1);
	String cookieUserId = CookieUtil.getValue(request, "USER_ID");
	
	FreeBbs board = null;
	
	String errorMessage = "";
	
	if(freeBbsSeq  > 0)
	{
		FreeBbsDao boardDao = new FreeBbsDao();
		board = boardDao.freeBbsSelect(freeBbsSeq);
		
		if(board != null)
		{
			if(!StringUtil.equals(cookieUserId, board.getUserId()))
			{
				board = null;
				errorMessage = "로그인 사용자의 게시물이 아닙니다.";
			}
		}
		else
		{
			errorMessage = "해당 게시글이 존재하지 않습니다.";
		}
		
	}
	else
	{
		errorMessage = "게시물 번호가 올바르지 않습니다..";
	}
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/lang/summernote-ko-KR.min.js"></script>
<style>
	.note-editor {
	    border: 2px solid #1e88e5; 
	    border-radius: 5px; 
	    font-family: "GmarketSans"; 
	}
	
	.note-editable {
	    border: 2px solid #1e88e5; 
	    background-color: #f0f5fa; 
	    color: #7B8AB8; 
	    min-height: 500px; 
	    padding: 10px; 
	    border-radius: 5px;
	}
	
	.note-editable:focus {
    	border: 4px solid #abccee;
	}
		
	.note-toolbar {
	    background-color: #f0f5fa;
	    border-radius: 5px; 
	    margin-bottom: 5px; 
	}
</style>
<script>
  $(document).ready(function() {
	  $("#freeBbsTitle").focus();
      $("#freeBbsContent").summernote({
          lang: 'ko-KR',
          toolbar: [
              ["insert", ['picture']],
              ["fontname", ["fontname"]],
              ["fontsize", ["fontsize"]],
              ["color", ["color"]],
              ["style", ["style"]],
              ["font", ["strikethrough", "superscript", "subscript"]],
	          ["table", ["table"]],
	          ["para", ["ul", "ol", "paragraph"]],
	          ["height", ["height"]],
	      ],
	      fontNames: ['GmarketSans', 'Nanum Gothic', 'Noto Sans KR', 'Spoqa Han Sans'],
	      fontNamesIgnoreCheck: ['GmarketSans', 'Nanum Gothic', 'Noto Sans KR', 'Spoqa Han Sans'], 
	  });
      
 <% 
 	if(board == null)
 	{
 %>
	     alert("<%=errorMessage%>");
	     location.href = "/board/freeList.jsp";
 <%
 	}
 	else
 	{
 %>
		 $("#bbsTitle").focus();
		 
			$("#btnFreeList").on("click", function(){
				document.freeUpdateForm.action = "/board/freeList.jsp";
				document.freeUpdateForm.submit();
			});
			
	      $("#btnFreeUpdate").on("click", function(){
	    	  
	    	 if($.trim($("#freeBbsTitle").val()).length === 0) {
	    		 alert("게시글 제목을 입력해주세요.");
	    		 $("#freeBbsTitle").val("");
	    		 $("#freeBbsTitle").focus();
	    		 return;
	    	 } 
	    	 
	    	 if($.trim($("#freeBbsContent").val()).length === 0) {
	    		 alert("게시글 내용을 입력해주세요.");
	    		 $("#freeBbsContent").val("");
	    		 $('#freeBbsContent').focus();
	    		 return;
	    	 }
	    	 
	    	 document.freeUpdateForm.submit();
    	 
    	  });
 <%
 	}
%>
  });
</script>
</head>
<body>
	
<%@ include file="/include/navigation.jsp" %>
<div class="container">
   <br />
   <h2>자유 게시물 수정</h2>
   	<form name="freeUpdateForm" id="freeUpdateForm" action="/board/freeUpdateProc.jsp" method="post">
      <input type="text" name="freeUserId" id="freeUserId" maxlength="20" value="<%=board.getUserId()%>" style="ime-mode:active;"class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="freeBbsTitle" id="freeBbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="게시글 제목" required />
      <div class="form-group">
         <textarea class="form-control" name="freeBbsContent" id="freeBbsContent" style="ime-mode:active;" required></textarea>
      </div>
       <input type="hidden" name="freeBbsSeq" value="<%=freeBbsSeq%>"/>
		<input type="hidden" name="searchType" value="<%=searchType%>"/>
		<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
		<input type="hidden" name="currentPage" value="<%=currentPage%>"/>
      <div class="form-group row">
         <div class="col-sm-12">
            <div class="d-flex justify-content-end mt-4">
            <button type="button" id="btnFreeUpdate" class="btn btn-outline-primary me-2" title="수정" style="background-color: #3f51b5;">수정</button>
            <button type="button" id="btnFreeList" class="btn btn-outline-primary" title="리스트">리스트</button>
            </div>
         </div>
      </div>
   </form>
<%@ include file="/include/footer.jsp" %>
</body>
</html>