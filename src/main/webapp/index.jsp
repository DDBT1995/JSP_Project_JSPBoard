<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.logging.log4j.LogManager"%>
<%@	page import="org.apache.logging.log4j.Logger"%>
<%@ page import="com.sist.common.util.StringUtil"%>
<%@ page import="com.sist.web.util.CookieUtil"%>
<%@ page import="com.sist.web.util.HttpUtil"%>
<%@ page import="com.sist.web.dao.FreeBbsDao"%>
<%@ page import="com.sist.web.model.FreeBbs"%>
<%@ page import="com.sist.web.model.PageConfig"%>
<%@ page import="com.sist.web.model.Paging"%>
<%@ page import="com.sist.web.model.User" %>
<%@ page import="com.sist.web.dao.UserDao" %>

<%
Logger logger = LogManager.getLogger("/board/index.jsp");
HttpUtil.requestLogString(request, logger);
long currentPage = HttpUtil.get(request, "currentPage", (long) 1);
long freeBbsSeq = HttpUtil.get(request, "freeBbsSeq", (long)0);

String cookieUserId = CookieUtil.getValue(request,"USER_ID","");
UserDao userDao = new UserDao();
User user =  null;

if(cookieUserId != null && !cookieUserId.equals(""))
{
	user = userDao.userSelect(cookieUserId);
}


long totalCount = 0;
//게시물 리스트
List<FreeBbs> list = null;
//페이징 객체
Paging paging = null;

FreeBbs search = new FreeBbs();
FreeBbs board2 = new FreeBbs();
FreeBbsDao boardDao = new FreeBbsDao();
board2 = boardDao.freeBbsSelect(freeBbsSeq);

totalCount = boardDao.freeBbsTotalPost(search);
logger.debug("=============================");
logger.debug("totalCount : " + totalCount);
logger.debug("=============================");

if (totalCount > 0) 
{	
	// 이 쪽 부분 하드코딩 웹당 개시물, 웹당 페이지
	paging = new Paging(totalCount, PageConfig.NUM_OF_POST_PER_PAGE, PageConfig.NUM_OF_PAGE_PER_BLOCK, currentPage);
	
	search.setStartPost(paging.getStartPost());
	search.setEndPost(paging.getEndPost());
	
	list = boardDao.freeBbsList(search);
	logger.debug("list size()11111111111111111" + list.size());
}
%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>

<%
	String cpIdSchYn = (String)session.getAttribute("idSchYn");
	session.removeAttribute("idSchYn");
%>
<script>
$(document).ready(function(){
   $("#btnFree").on("click", function(){
       location.href = "/board/freeList.jsp";
       });
   
   $("#btnStore").on("click", function(){
       location.href = "/board/storeList.jsp";
       });
   
   
<% if(cpIdSchYn != null && "1".equals(cpIdSchYn)) { %>
  			 showModal();
<% } %>
   
   <% if(cpIdSchYn != null && "2".equals(cpIdSchYn)) { %>
	 showModal();
<% } %>
});

</script>

<style>
    .card-header h2 {
        margin: 0;
        font-size: 1.5rem; /* 고정 크기 */
    }

    .table th, .table td {
        white-space: nowrap; /* 셀 내용 줄바꿈 방지 */
    }

    /* 반응형 텍스트 크기 조정 */
    .blockquote p {
        font-size: 1rem; /* 기본 크기 */
    }

    @media (max-width: 768px) {
        .card-header h2 {
            font-size: 1.2rem; /* 작은 화면에서 약간 줄어듦 */
        }
    }

    @media (min-width: 768px) {
        .card-header h2 {
            font-size: 1.5rem; /* 큰 화면에서 고정 크기 유지 */
        }
    }
</style>
<script>
$(document).ready(function(){
   $("#btnFree").on("click", function(){
       location.href = "/board/freeList.jsp";
       });
   
   $("#btnStore").on("click", function(){
       location.href = "/board/storeList.jsp";
       });
   
	 });

function fn_view(freeBbsSeq)
{
	document.freeBbsForm.freeBbsSeq.value = freeBbsSeq;
	document.freeBbsForm.action = "/board/freeView.jsp";
	document.freeBbsForm.submit();
}
function fn_Recom(freeBbsSeq)
{
	document.freeBbsForm.freeBbsSeq.value = freeBbsSeq;
	document.freeBbsForm.action = "/board/freeRecom.jsp";
	document.freeBbsForm.submit();
}
</script>

 <style>
    body  {
      background-image: url('https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjAyMDJfMTkg%2FMDAxNjQzNzcxNTg2NTEw.6hLd3W3-gTtgRhF_eF3kJ8q95tMkmytc1oZjLQEz0vgg.xhmg3cE0mnOfmliG7YD0SWYFHNFO6MIlxgxNkR5qtT4g.JPEG.hehen_n%2FIMG_1825.JPG&type=sc960_832');
      background-size: cover;
      background-position: center;
       background-size: 15%; 
    }
  </style>
</head>
<body>
<%@ include file="/include/navigation.jsp" %>
<div class="container mt-4">
    <div class="row">
        <!-- 공지사항 카드 -->
        <div class="col-md-12 mb-3">
            <div class="card bg-light mb-3">
                <div class="card-header"><h2><i class="fa-solid fa-clipboard-check"></i> 공지사항</h2></div>
                <div class="card-body">
                    <ul>
                        <li>새로운 기능 업데이트가 적용되었습니다.</li>
                        <li>2024년 10월 1일 서버 점검이 예정되어 있습니다.</li>
                        <li>이벤트 참가 신청이 시작되었습니다!</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 인기 게시물 카드 -->
        <div class="col-md-12 mb-3">
            <div class="card bg-light mb-3">
                <div class="card-header"><h2><i class="fa-solid fa-fire"></i> 인기 게시물 (추천순)</h2></div>
                <div class="card-body">
                    <ul>
                        <li><a href="#">가장 인기 있는 게시물 제목 1</a></li>
                        <li><a href="#">가장 인기 있는 게시물 제목 2</a></li>
                        <li><a href="#">가장 인기 있는 게시물 제목 3</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 자유 게시판 카드 -->
        <div class="col-md-6 mb-3">
            <div class="card text-white bg-info mb-3">
                <div class="card-header"><h2><i class="fa-solid fa-list"></i> 자유 게시판</h2></div>
                <div class="card-body d-flex flex-column">
                    <div class="table-responsive">
                        <table class="table table-info">
                            <thead>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">작성일</th>
                                    <th scope="col">추천</th>
                                </tr>
                            </thead>
                            <tbody>
                               	<%
								if (list != null && list.size() > 0) {
									long postNumber = paging.getPostNumber();

									for (int i = 0; i < list.size(); i++) {
										logger.debug("2222222222222222222222222222");
										FreeBbs board = list.get(i);
										//logger.debug("33333333333333  user.getUserId() : " + user.getUserId());
										logger.debug("4444444444444 freeBbs.getFreeBbsSeq() : " + board.getFreeBbsSeq());										
										boolean isLiked = false;
										if(cookieUserId != null && !cookieUserId.equals("") && user != null)
										{
											//isLinked = (boardDao.freeRecomCheck(user, board) > 0) ? true : false ;
											if(boardDao.freeRecomCheck(user, board) > 0)
											{
												isLiked = true;
											}
											else
											{
												isLiked = false;
											}
										}
										else
										{
											isLiked = false;
										}
										
										board.setLiked(isLiked); 
								%>
								<tr class="table-light">
									<td class="text-left"><%=postNumber%></td>
									<td><a href="javascript:void(0)"
										onclick="fn_view(<%=board.getFreeBbsSeq()%>)"><%=board.getFreeBbsTitle()%></a></td>
									<td class="text-left"><%=board.getUserName()%></td>
									<td class="text-left"><%=board.getRegDate()%></td>
									 <td><button id="btnFreeRecom" onclick="fn_Recom(<%=board.getFreeBbsSeq()%>)" class="btn btn-outline-light btn-sm">좋아요
									 <% if (board.isLiked()) { %>
								    	&#129505;
										<% }else {%>
										
										<i class="fa-sharp-duotone fa-solid fa-heart"></i> 
									<%} %>
									 </button></td>
									
								</tr>
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
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-end mt-auto">
                        <button type="button" id="btnFree" class="btn btn-outline-light btn-sm">전체보기</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 음식점 게시판 카드 -->
        <div class="col-md-6 mb-3">
            <div class="card text-white bg-info mb-3">
                <div class="card-header"><h2><i class="fa-solid fa-list-check"></i> 음식점 게시판</h2></div>
                <div class="card-body d-flex flex-column">
                    <div class="table-responsive">
                        <table class="table table-info">
                            <thead>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">작성일</th>
                                    <th scope="col">추천</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="table-light">
                                    <th scope="row">1</th>
                                    <td>음식점 게시판 글 제목 1</td>
                                    <td>작성자1</td>
                                    <td>2024-09-19</td>
                                    <td><button class="btn btn-outline-light btn-sm">좋아요</button></td>
                                </tr>
                                <tr class="table-light">
                                    <th scope="row">2</th>
                                    <td>음식점 게시판 글 제목 2</td>
                                    <td>작성자2</td>
                                    <td>2024-09-18</td>
                                    <td><button class="btn btn-outline-light btn-sm">좋아요</button></td>
                                </tr>
                                <tr class="table-light">
                                    <th scope="row">3</th>
                                    <td>음식점 게시판 글 제목 3</td>
                                    <td>작성자3</td>
                                    <td>2024-09-17</td>
                                    <td><button class="btn btn-outline-light btn-sm">좋아요</button></td>
                                </tr>
                                  <tr class="table-light">
                                    <th scope="row">4</th>
                                    <td>음식점 게시판 글 제목 4</td>
                                    <td>작성자4</td>
                                    <td>2024-09-17</td>
                                    <td><button class="btn btn-outline-light btn-sm">좋아요</button></td>
                                </tr>
                                  <tr class="table-light">
                                    <th scope="row">5</th>
                                    <td>음식점 게시판 글 제목 5</td>
                                    <td>작성자5</td>
                                    <td>2024-09-17</td>
                                    <td><button class="btn btn-outline-light btn-sm">좋아요</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex justify-content-end mt-auto">
                        <button type="button" id="btnStore" class="btn btn-outline-light btn-sm">전체보기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 사용자 피드백 섹션 -->
    <div class="row mb-3">
        <div class="col-md-12">
            <div class="card bg-light mb-3">
                <div class="card-header"><h2><i class="fa-solid fa-comment-dots"></i> 사용자 피드백</h2></div>
                <div class="card-body">
                    <blockquote class="blockquote">
                        <p class="mb-0">"이 사이트는 정말 유용해요!"</p>
                    </blockquote>
                    <blockquote class="blockquote">
                        <p class="mb-0">"사용하기 간편하고 필요한 정보가 많아요."</p>
                    </blockquote>
                </div>
            </div>
        </div>
    </div>
</div>
								<form name="freeBbsForm" id="freeBbsForm" method="post">
										<input type="hidden" name="freeBbsSeq" value="" />
										<input type="hidden" name="currentPage" value="<%=currentPage%>" />
								</form>
<%@ include file="/include/footer.jsp" %>
</body>
</html>