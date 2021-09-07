<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">게시글 조회</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 조회</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <!-- 페이징 값 -->
                    <input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum}"/>' >
                    <input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount}"/>' >
                    <!-- 검색 값 -->
                    <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' >
                    <input type='hidden' name='type' value='<c:out value="${cri.type}"/>' >
                    <div class="form-group">
                        <label>게시글 번호</label>
                        <input class="form-control" name='bno' readonly="readonly"
                               value='<c:out value="${board.bno}"/>' >
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" name='title'
                               value='<c:out value="${board.title}"/>' >
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" style="resize: none;" rows="3" name='content'><c:out value="${board.content }"/></textarea>
                    </div>
                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" name='writer' readonly="readonly"
                               value='<c:out value="${board.writer}"/>' >
                    </div>
                    <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                    <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                    <button type="submit" data-oper='list' class="btn btn-info">목록</button>
                </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<script>
    $(document).ready(() => {
        const formObj = $("form");

        $("button").on("click", (e) => {
            e.preventDefault();
            const oper = e.target.dataset.oper;
            if (oper === 'remove') {
                formObj.attr("action", "/board/remove");
            } else if (oper === 'list') {
                formObj.attr("action", "/board/list").attr("method", "get");
                const pageNumInput = document.querySelector("input[name='pageNum']").cloneNode();
                const amountInput = document.querySelector("input[name='amount']").cloneNode();
                const keywordInput = document.querySelector("input[name='keyword']").cloneNode();
                const typeInput = document.querySelector("input[name='type']").cloneNode();

                formObj.empty();
                formObj.append(pageNumInput);
                formObj.append(amountInput);
                formObj.append(keywordInput);
                formObj.append(typeInput);
                // self.location = "/board/list";
            }
            formObj.submit();
        });
    });
</script>
<%@include file="../includes/footer.jsp"%>