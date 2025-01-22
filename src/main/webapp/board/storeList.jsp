<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="/include/header.jsp" %>

  <script>
    $(document).ready(function() {
      // 음식점 게시판 버튼 클릭 이벤트
      $("#btnStoreList_Write").on("click", function() {
        location.href = "/board/storeWrite.jsp";
      });
    });
  </script>
</head>
<body>

  <%@ include file="/include/navigation.jsp" %>
  <div style="display: flex; justify-content: center; align-items: center; flex-wrap: wrap; margin-top: 40px;">
    <input type="text" name="_searchValue" id="_searchValue" value="" 
           class="form-control mx-1" maxlength="20" 
           style="flex: 1; max-width: 800px; ime-mode: active; margin-right: 10px; width: 800px;" 
           placeholder="검색." />
    <button type="button" id="btnSearch"  
            class="btn btn-outline-light mb-3 mx-1">검색</button>
  </div>
  
  <div class="container mt-4">
    <div class="row">
      <!-- 자유 게시판 카드 -->
      <div class="col-md-12"> <!-- 12로 변경하여 전체 너비 사용 -->
        <div class="card text-white bg-info mb-3">
          <div class="card-header">
            <h2>음식점 게시판</h2>
          </div>
          <div class="card-body d-flex flex-column">
            <table class="table table-info">
              <thead>
                <tr>
                  <th scope="col">번호</th>
                  <th scope="col">제목</th>
                  <th scope="col">작성자</th>
                  <th scope="col">작성일</th>
                </tr>
              </thead>
              <tbody>
                <tr class="table-light">
                  <th scope="row">1</th>
                  <td>맛집 게시판 글 제목 1</td>
                  <td>작성자1</td>
                  <td>2024-09-19</td>
                </tr>
                <tr class="table-light">
                  <th scope="row">2</th>
                  <td>맛집 게시판 글 제목 2</td>
                  <td>작성자2</td>
                  <td>2024-09-18</td>
                </tr>
                <tr class="table-light">
                  <th scope="row">3</th>
                  <td>맛집 게시판 글 제목 3</td>
                  <td>작성자3</td>
                  <td>2024-09-17</td>
                </tr>
                <!-- 나머지 7개의 게시글 추가 -->
              </tbody>
            </table>
            <div>
              <div>
                <ul class="pagination d-flex justify-content-between mb-0 w-100">
                  <li class="page-item disabled">
                    <a class="page-link" href="#">&laquo;</a>
                  </li>
                  <li class="page-item active flex-fill text-center">
                    <a class="page-link" href="#">1</a>
                  </li>
                  <li class="page-item flex-fill text-center">
                    <a class="page-link" href="#">2</a>
                  </li>
                  <li class="page-item flex-fill text-center">
                    <a class="page-link" href="#">3</a>
                  </li>
                  <li class="page-item flex-fill text-center">
                    <a class="page-link" href="#">4</a>
                  </li>
                  <li class="page-item flex-fill text-center">
                    <a class="page-link" href="#">5</a>
                  </li>
                  <li class="page-item">
                    <a class="page-link" href="#">&raquo;</a>
                  </li>
                  <li class="ms-auto">
                    <button type="button" id="btnStoreList_Write" class="btn btn-outline-light d-flex align-items-center">
                      <i class="fa-sharp-duotone fa-solid fa-pen me-1"></i>
                      <span>음식점 글쓰기</span>
                    </button>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>