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
                    <div class="form-group">
                        <label>게시글 번호</label>
                        <input class="form-control" name='bno'
                               value='<c:out value="${board.bno}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" name='title'
                               value='<c:out value="${board.title}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content }"/></textarea>
                    </div>
                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" name='writer'
                               value='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>

                    <button data-oper='modify' class="btn btn-default">수정</button>
                    <button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">목록</button>
                    <!-- 공통 form 데이터 -->
                    <form id="openForm" action="/board/modify" method="get">
                        <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>' >
                        <input type='hidden' id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum}"/>' >
                        <input type='hidden' id='amount' name='amount' value='<c:out value="${cri.amount}"/>' >
                        <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' >
                        <input type='hidden' name='type' value='<c:out value="${cri.type}"/>' >
                    </form>
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i claass="fa fa-comments fa-fw"></i>답글
                    <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>답글 달기</button>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <ul class="chat">
                        <!-- <li> reply -->
                    </ul>
                    <!--  ./end ul -->
                </div>
                <!-- ./ end row -->

                <div class="panel-footer">
                <!-- ./ end row -->
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Reply</label>
                        <input class="form-control" name='reply' value='New Reply!!!!'>
                    </div>
                    <div class="form-group">
                        <label>Replyer</label>
                        <input class="form-control" name='replyer' value='replyer'>
                    </div>
                    <div class="form-group">
                        <label>Reply Date</label>
                        <input class="form-control" name='replyDate' value=''>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                    <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                    <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>

                    <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
                </div>
            </div>
        </div>
    </div>
    <script src="/resources/js/reply.js"></script>
    <script>
        $(document).ready(function() {
            const bnoValue = '<c:out value="${board.bno}"/>';
            var replyUL = $(".chat");

            showList(1);

            function showList(page) {
                replyService.getList({bno:bnoValue, page:page || 1}, function(replyCnt, list) {
                    let str = "";
                    if(page == -1) {
                        pageNum = Math.ceil(replyCnt/10.0);
                        showList(pageNum);
                        return;
                    }

                    if(list == null || list.length==0) {
                        replyUL.html("");
                        return;
                    }
                    for (let i=0, len=list.length || 0; i<len; i++) {
                        str+= "<li class='left cleafix' data rno='"+list[i].rno+"'>";
                        str+= "    <div><div class='header'><string class='primary-font'>"+list[i].replyer+"</strong>";
                        str+= "        <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate)+"</small></div>";
                        str+= "            <p>"+list[i].reply+"</p></div></li>";
                    }

                    replyUL.html(str);
                    showReplyPage(replyCnt);
                });
            }

            var pageNum = 1;
            var replyPageFooter = $(".panel-footer");
            function showReplyPage(replyCnt) {
                var endNum = Math.ceil(pageNum / 10.0) * 10;
                var startNum = endNum - 9;

                var prev = startNum != 1;
                var next = false;

                if(endNum * 10 >= replyCnt) {
                    endNum = Math.ceil(replyCnt/10.0);
                }

                if(endNum * 10 < replyCnt) {
                    next = true;
                }

                var str = "<ul class='pagination pull-right'>";
                if(prev) {
                    str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
                }

                for(var i=startNum ; i<=endNum; i++){
                    var active = pageNum == i? "active":"";
                    str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
                }

                if(next) {
                    str+= "<li class='page-item'><a class='page-link' href='"+(endNum+1) + "'>Next</a></li>";
                }

                str += "</ul></div>";

                replyPageFooter.html(str);
            }

            var modal = $(".modal");
            var modalInputReply = modal.find("input[name='reply']");
            var modalInputReplyer = modal.find("input[name='replyer']");
            var modalInputReplyDate = modal.find("input[name='replyDate']");

            var modalModBtn = $("#modalModBtn");
            var modalRemoveBtn = $("#modalRemoveBtn");
            var modalRegisterBtn = $("#modalRegisterBtn");
            var modalCloseBtn = $("#modalCloseBtn");

            $("#addReplyBtn").on("click", function(e) {
                modal.find("input").val("");
                modalInputReplyDate.closest("div").hide();
                modal.find("button[id!='modalCloseBtn']").hide();

                modalRegisterBtn.show();
                $(".modal").modal("show");
            });

            $("#addReplyBtn").on("click", function(e) {
                modal.find("input").val("");
                modalInputReplyDate.closest("div").hide();
                modal.find("button[id!='modalCloseBtn']").hide();

                modalRegisterBtn.show();
                $(".modal").modal("show");
            });

            modalRegisterBtn.on("click", function(e) {
                var reply ={
                    reply: modalInputReply.val(),
                    replyer: modalInputReplyer.val(),
                    bno: bnoValue
                };

                replyService.add(reply, function (result){
                    alert(result);
                    modal.find("input").val("");
                    modal.modal("hide");

                    showList(-1);
                });
            });

            modalModBtn.on("click", function(e) {
                const reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
                replyService.update(reply, function(result) {
                    alert(result);
                    modal.modal("hide");
                    showList(pageNum);
                });
            });

            modalRemoveBtn.on("click", function(e) {
                const rno = modal.data("rno");
                replyService.remove(rno, function(result) {
                    alert(result);
                    modal.modal("hide");
                    showList(pageNum);
                });
            });

            modalCloseBtn.on("click", function (e) {
                modal.modal("hide");
            });

            replyPageFooter.on("click", "li a", function(e) {
                e.preventDefault();
                console.log("page click");
                var targetPageNum = $(this).attr("href");
                console.log("targetPageNum : " + targetPageNum);
                pageNum = targetPageNum;
                showList(pageNum);
            });

            $(".chat").on("click", "li", function(e) {
                const rno = $(this).attr('rno');
                replyService.get(rno, function(reply) {
                    modalInputReply.val(reply.reply);
                    modalInputReplyer.val(reply.replyer);
                    modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                    modal.data("rno", reply.rno);

                    modal.find("button[id != 'modalCloseBtn']").hide();
                    modalModBtn.show();
                    modalRemoveBtn.show();

                    $(".modal").modal("show");
                });
            });
        });
    </script>
    <script>
        $(document).ready(() => {
            const openForm = $("#openForm");
            $("button[data-oper='modify']").on("click", (e) => {
                openForm.attr("action", "/board/modify").submit();
            });

            $("button[data-oper='list']").on("click", (e) => {
                openForm.find("#bno").remove();
                openForm.attr("action", "/board/list");
                openForm.submit();
            });


        });
    </script>
</div>
<%@include file="../includes/footer.jsp"%>