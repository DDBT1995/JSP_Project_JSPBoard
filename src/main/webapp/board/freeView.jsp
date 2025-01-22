<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao" %>
<%@ page import="com.sist.web.model.FreeBbs" %>
<%@ page import="java.util.List"%>
<%@ page import="com.sist.web.model.FreeCom" %>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.PageConfig"%>
<%@ page import="com.sist.web.model.Paging2"%>


<%
	Logger logger = LogManager.getLogger("/board/freeView.jsp");
	HttpUtil.requestLogString(request,logger);
	
	String cookieUserId = CookieUtil.getValue(request,"USER_ID", "");
	
	long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	long freeComBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);
	
	String searchType = HttpUtil.get(request,"searchType", "");
	String searchValue = HttpUtil.get(request, "searchValue", "");
	long currentPage = HttpUtil.get(request, "currentPage", (long)1);
	long currentComPage = HttpUtil.get(request, "currentComPage", (long)1);
	
	logger.debug("============  freeList에서 view로 값 잘 넘어왔나 =============");
	logger.debug("cookieUserId : " + cookieUserId);
	logger.debug("freeBbsSeq : " + freeBbsSeq);
	logger.debug("searchType : " + searchType);
	logger.debug("searchValue : " + searchValue);
	logger.debug("currentPage : " + currentPage);
	logger.debug("========================================================");
	
	
	UserDao userDao = new UserDao();
	
	
	
	User user = null;
	if(cookieUserId != null && !cookieUserId.equals(""))
	{
		user = userDao.userSelect(cookieUserId);
	}
		
	
	FreeBbsDao boardDao = new FreeBbsDao();
	FreeBbs board = boardDao.freeBbsSelect(freeBbsSeq);
	
	// 댓글 관련 소스

	List<FreeCom> listCom = null;
	FreeCom search = new FreeCom();
	
	Paging2 paging2 = null;
	
	long totalComCount = 0;
	
	
	if(board != null)
	{
		// 조회수 증가
		boardDao.freeBbsReadCntPlus(freeBbsSeq);
		
		// 댓글 리스트 불러오기 불러올 게시물번호 저장하고 
		search.setFreeBbsSeq(freeBbsSeq);
		
		logger.debug("getFreeBbsSeq" + search.getFreeBbsSeq());
		
		totalComCount = boardDao.freeComTotal(search);
		
		logger.debug("totalComCount" + totalComCount);
		
		if(totalComCount > 0)
		{
			paging2 = new Paging2(totalComCount, PageConfig.NUM_OF_POST_PER_PAGE, PageConfig.NUM_OF_PAGE_PER_BLOCK, currentComPage);
			
			search.setStartPost(paging2.getStartPost());
			search.setEndPost(paging2.getEndPost());
			
			// 댓긃 리스트에 불러오기
			listCom = boardDao.freeComBbsList(search);
			logger.debug("listCom size()" + listCom.size());
		}
		else
		{
			logger.debug("댓글 카운트 값 오류......");
		}
	}
	else
	{
		logger.debug("삭제된 게시물 입니다. 추가 하기.....");
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp"%>
<script>
$(document).ready(function(){
<%
	if(board == null)
	{
%>
	alert("조회하신 게시물이 존재하지 않습니다.");
	document.freeBbsForm.action = "/board/freeList.jsp";
	document.freeBbsForm.submit();
<%	
	}
	else
	{
%>
	
		 $("#btnFreeList").on("click",function(){
			document.freeBbsForm.action = "/board/freeList.jsp";
			document.freeBbsForm.submit();
			
		 });
		 
		 $("#btnFreeRecom").on("click",function(){
				document.freeBbsForm.action = "/board/freeRecom.jsp";
				document.freeBbsForm.submit();
<%				
			if(user != null)
			{
				if (boardDao.freeRecomCheck(user, board) > 0)
				{	
					
					
					session.setAttribute("liked", true);
				}
				else
				{
				
					session.setAttribute("liked", false);
				}
			}
		
%>
			 });
		 
<%			
		if(cookieUserId != null && !cookieUserId.equals(""))
		{
			if(StringUtil.equals(cookieUserId, board.getUserId()))
			{
%>
			$("#btnFreeUpdate").on("click",function(){
				
				document.freeBbsForm.action = "/board/freeUpdate.jsp";
				document.freeBbsForm.submit();
			});
			
			$("#btnFreeDelete").on("click", function(){
				if(confirm("게시물을 삭제 하시겠습니까?") == true)
				{
					document.freeBbsForm.action = "/board/freeDelete.jsp";
					document.freeBbsForm.submit();
				}
			});
			
<%
		 	}
		}
%>
		$('#btnFreeComWrite').on('click', function() {
			$.ajax({
			    type: "POST",
			    url: "/board/freeComWriteAjax.jsp",
			    data: {	
			    		freeBbsSeq: "<%=freeBbsSeq%>",
			    		userId: "<%=cookieUserId%>",
			    		commentText: $("#commentText").val() 
			    		},
			    datatype: "JSON", 
			    success: function(obj) {
			  	  var data = JSON.parse(obj);
			  	  alert("flag : " + data.flag);
			
			  	  if(data.flag == 0)
			  	  {
			  		alert("로그인 후 댓글 작성 가능합니다.");
			  	  }
			  	  else if(data.flag == 1)
			      {
			  		alert("댓글 저장 완료");
			  		$("#commentText").val("");
			  		location.reload(true);
			  		
			      }
			  	  else
			  	 {
			  		alert("댓글 저장 오류");
			  	 }
			      
			    },
			    error: function(xhr, status, error)
			    {
			    	alert("Ajax 에러!!");
			    }
			});
		});
<%
	}
%>


 });
 
function fn_Comlist(currentComPage)
{	
	
	document.freeBbsForm.currentComPage.value = currentComPage;
	document.freeBbsForm.action = "/board/freeView.jsp";
	document.freeBbsForm.submit();
}

</script>
</head>
<body>
	<%@include file="/include/navigation.jsp"%>
<body>
	<div class="container mt-5">
		<h2>자유 게시물</h2>
		<div class="row" style="margin-right: 0; margin-left: 0;">
			<table class="table table-hover">
				<thead>
					<tr class="table-active">
						<th scope="col" style="width: 60%"><%=board.getFreeBbsTitle()%><br /> 작성자:
							<%=board.getUserName()%>&nbsp;&nbsp;&nbsp; <a href="mailto:hong@example.com"
							style="color: #828282;"></a>
						</th>
						<th scope="col" style="width: 40%" class="text-end"><%=board.getFreeBbsReadCnt()%><br />
							<%=board.getRegDate()%>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2"><pre style="white-space: pre-wrap;"><%=board.getFreeBbsContent()%><br>HTML에서 줄바꿈을 표시하게 됩니다.</pre>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2"></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="d-flex">
			<button type="button" id="btnFreeList" class="btn btn-secondary me-2">리스트</button>
<%			
			if(cookieUserId != null && !cookieUserId.equals(""))
			{
				if(StringUtil.equals(cookieUserId, board.getUserId()))
				{
%>
				<button type="button" id="btnFreeUpdate" class="btn btn-secondary me-2">수정</button>
				<button type="button" id="btnFreeDelete" class="btn btn-secondary">삭제</button>
<%
				}
			}
%>		
		<button type="button" id="btnFreeRecom" class="btn btn-secondary">좋아요
		<% if (Boolean.TRUE.equals(session.getAttribute("liked")) && !StringUtil.isEmpty(cookieUserId)) { %>
    	&#129505;
		<% }else {%>
		
		<i class="fa-sharp-duotone fa-solid fa-heart"></i> 
		<%} %>
		
		</button>
		</div>
		<hr>
		<div class="comments-section mt-4">
			<h5>댓글</h5>
			<%
			if (listCom != null && listCom.size() > 0) {
				long postNumber = paging2.getPostNumber();
				for (int i = 0; i < listCom.size(); i++) {
					FreeCom boardCom = listCom.get(i);
			
			%>
			<div class="card mb-3">
				<div class="card-body">
					<h6 class="card-title">댓글 번호 : <%=postNumber%>
					<h6 class="card-title">댓글 작성자 : <%=boardCom.getUserName() %> </h6>
					<p class="card-text"><%=boardCom.getFreeComContent() %></p>
					<p class="card-text">
						<small class="text-muted"><%=boardCom.getRegDate() %></small>
					</p>
				</div>
			</div>
			<%
			postNumber--;					
				}
			} else {
			%>
			<tr>
				<td colspan="5" class="text-center">해당 데이터가 존재하지 않습니다.</td>
			</tr>

			<%
				}
			%>
			<ul class="pagination d-flex justify-content-between mb-0 w-100">
					<%
					if (paging2 != null) {
						if (paging2.getPrevBlockPage() > 0) {
					%>
					<li class="page-item"><a class="page-link"
						href="javascript:void(0)" onclick="fn_Comlist(<%=paging2.getPrevBlockPage()%>)">&laquo;</a></li>
					<%
					}
					for (long i = paging2.getStartPage(); i <= paging2.getEndPage(); i++) {
					if (paging2.getCurrentComPage() != i) {
						// 현재 페이지가 i가 다를떄 버튼 활성화
					%>
					<li class="page-item active flex-fill text-center"><a
						class="page-link" href="javascript:void(0)" id="btFreeCom"
						onclick="fn_Comlist(<%=i%>)"><%=i%></a></li>
					<%
					} else { // // 현재 페이지가 i가 같을때 버튼 비활성화
					%>
					<li class="page-item active flex-fill text-center"><a
						class="page-link" href="javascript:void(0)"
						style="cursor: default;"><%=i%></a></li>
					<%
					}
					}
					if (paging2.getNextBlockPage() > 0) {
					%>
					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_Comlist(<%=paging2.getNextBlockPage()%>)">&raquo;</a>
					</li>
					<%
					}
					}
					%>
			</ul>
			<!-- 댓글 입력 폼 -->
			<div class="mt-4">
				<h5>댓글 작성</h5>
				<form name="freeComForm" method="Post">
					<div class="mb-3">
						<label for="commentText" class="form-label">댓글 내용</label>
						<textarea class="form-control" id="commentText" name="commentText" rows="3"
							placeholder="댓글을 입력하세요."></textarea>
					</div>
					<button type="button" id="btnFreeComWrite" class="btn btn-primary">댓글 작성</button>
				</form>
			</div>
		</div>
	</div>
	<form name="freeBbsForm" method="post">
		<input type="hidden" name="freeBbsSeq" value="<%=freeBbsSeq%>"/>
		<input type="hidden" name="searchType" value="<%=searchType%>"/>
		<input type="hidden" name="searchValue" value="<%=searchValue%>"/>
		<input type="hidden" name="currentPage" value="<%=currentPage%>"/>
		<input type="hidden" name="currentComPage" value="<%=currentComPage%>"/>
	</form>
	<%@include file="/include/footer.jsp"%>
</body>
</html>