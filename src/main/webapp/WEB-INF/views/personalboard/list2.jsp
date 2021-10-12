<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header2.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0"><c:out value="${dto.tag}"></c:out></h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Dashboard v1</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- Main row -->
                <div class="row">
                    <!-- Left col -->
                    <section class="col-lg-12">
                        <!-- TO DO List -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Board Table</h3>
                                <div align="right"><button><a href="/personalboard/register">게시글등록</a></button></div>

                            <!-- /.card-header -->
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th hidden style="width: 20px">NUM</th>
                                        <th>TITLE</th>
                                        <th>CONTENT</th>
                                        <th>PICTURE</th>
                                        <th>REGDATE</th>
                                        <th>MODDATE</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${dtoList}" var="dto">
                                    <tr>
                                        <td hidden><c:out value="${dto.bNum}"></c:out></td>
                                        <c:set var="year" value="${fn:substring(dto.bRegDate, 0, 4)}" />
                                        <c:set var="month" value="${fn:substring(dto.bRegDate, 6, 7)}" />
                                        <c:set var="date" value="${fn:substring(dto.bRegDate, 8, 10)}" />
                                        <td><a href="javascript:moveRead(${dto.bNum})">${year}년 ${month}월 ${date}일의 추억 </a></td>

                                        <c:set var="ct" value="${dto.content}" />
                                        <c:set var="ct2" value="${fn:trim(ct)}" />
                                        <c:if test= "${fn:length(ct2) > 0}">
                                           <td>be</td>
                                        </c:if>
                                        <c:if test= "${fn:length(ct2) == 0}">
                                            <td>be not in</td>
                                        </c:if>

                                        <td><c:out value="${dto.bPicCount}"></c:out></td>
                                        <td><c:out value="${dto.bRegDate}"></c:out></td>
                                        <td><c:out value="${dto.bModDate}"></c:out></td>


                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                                <form action="/personalboard/list" method="get">
                                    <input type="hidden" name="page" value="1">
                                    <input type="hidden" name="size" value="${pageMaker.size}">
                                <div class="col-sm-3">
                                    <!-- select -->
                                    <div class="form-group">
                                        <label>Search</label>
                                        <select name="type" class="custom-select">
                                            <option value="">---</option>
                                            <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                            <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목내용</option>
                                            <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                            <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>제목내용작성자</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control" name="${pageRequestDTO.keyword}">
                                        <span class="input-group-append"><button type="submit" class="btn btn-info btn-flat">Go!</button></span>
                                    </div>
                                </div>
                                </form>
                            </div>
                            <!-- /.card-body -->


                            <div class="card-footer clearfix">
                                <ul class="pagination pagination-sm m-0 float-right">

                                    <c:if test="${pageMaker.prev}">
                                    <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start -1})"> << </a></li>
                                    </c:if>

                                    <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="bNum">
                                    <li class="page-item ${pageMaker.page == bNum?'active':''}"><a class="page-link" href="javascript:movePage(${bNum})">${bNum}</a></li>
                                    </c:forEach>

                                    <c:if test="${pageMaker.next}">
                                        <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end +1})"> >> </a></li>
                                    </c:if>

                                </ul>
                            </div>
                        </div>
                        </div>
                        <!-- /.card -->
                    </section>

                    <!-- /.Left col -->
                </div>
                <!-- /.row (main row) -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Small Modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>One fine body&hellip;</p>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<form id="actionForm" action="/personalboard/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
    <input type="hidden" name="type" value="${pageRequestDTO.type}">
    <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@include file="../includes/footer2.jsp"%>

<script>

    const actionForm = document.querySelector("#actionForm")

    const result = '${result}'

    if(result && result !== ''){
        $('#modal-sm').modal('show')

        window.history.replaceState(null, '', '/personalboard/list');
    }

    function movePage(pagebNum){

        actionForm.querySelector("input[name='page']").setAttribute("value",pagebNum)
        actionForm.submit()

    }
    function moveRead(bNum){

        actionForm.setAttribute("action","/personalboard/read")
        actionForm.innerHTML +=`<input type='hidden' name='bNum' value='\${bNum}'>`
        actionForm.submit()

    }



</script>



</body>
</html>
