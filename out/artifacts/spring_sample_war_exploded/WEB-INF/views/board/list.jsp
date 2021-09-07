<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp" %>
<%-- list.jsp start --%>
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">게시글 목록</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">게시글 목록
                        <button id='regBtn' type="button" class="btn btn-xs pull-right" >
                            게시글 등록
                        </button>
                    </div>

                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                            <tr>
                                <th>게시글번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일자</th>
                                <th>수정일자</th>
                            </tr>
                            </thead>

                            <c:forEach items="${list}" var="board">
                                <tr class="odd gradeX">
                                    <td><c:out value="${board.bno }"/></td>
                                    <td>
                                        <a class="move" href="${board.bno}">
                                            <c:out value="${board.title }"/>
                                            <b> [ <c:out value="${board.replyCnt }" /> ]</b>
                                        </a>
                                    </td>
                                    <td><c:out value="${board.writer }"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
                                </tr>
                            </c:forEach>
                        </table>
                        <!-- 검색 바-->
                        <div class='row'>
                            <div class="col-lg-12">
                                <form id='searchForm' action="/board/list" method='get'>
                                    <select name='type'>
                                        <option value=""<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
                                        <option value="T"<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
                                        <option value="C"<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
                                        <option value="W"<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
                                        <option value="TC"<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
                                        <option value="TW"<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
                                        <option value="TWC"<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
                                    </select>
                                    <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
                                    <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'>
                                    <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>'>
                                    <button class='btn btn-default'>Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- 페이징 -->
                        <div class='pull-right'>
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev }">
                                    <li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">이전</a>
                                    </li>
                                </c:if>

                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">
                                    <li class="paginate_button next"> <a href="${num}">${num}</a> </li>
                                </c:forEach>

                                <c:if test="${pageMaker.next }">
                                    <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">다음</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                        <form id="actionForm" action="/board/list" method="get">
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
                            <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
                        </form>
                        <!-- Modal -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="myModalLabel">처리 알림</h4>
                                    </div>
                                    <div class="modal-body">처리가 완료되었습니다.</div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
<!-- 자바스크립트 소스 -->
<script type="text/javascript">
    $(document).ready(() => {
        const result='<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {
            if(result === '' || history.state) {
                return;
            }

            if(parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
            }

            $("#myModal").modal("show");
        }

        $("#regBtn").on("click", () => self.location="/board/register");

        const actionForm = $("#actionForm");
        $(".paginate_button a").on("click", (e) => {
            e.preventDefault();
            actionForm.find("input[name='pageNum']").val(e.target.innerText);
            actionForm.submit();
        });

        $(".move").on("click", (e) => {
            e.preventDefault();
            const bno = $(e.target).attr("href");
            actionForm.append("<input type='hidden' name='bno' value='" + bno + "'>")
            actionForm.attr("action", "/board/get");
            actionForm.submit();
        });

        $("#searchForm button").on("click", function(e) {
            if(!searchForm.find("option:selected").val()) {
                alert("검색 종류를 선택하세요");
                return false;
            }

            if(!searchForm.find("input[name='keyword']").val()) {
                alert("키워드를 입력하세요");
                return false;
            }

            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();

            searchForm.submit();
        });
    });
</script>
<%@ include file="../includes/footer.jsp" %>

