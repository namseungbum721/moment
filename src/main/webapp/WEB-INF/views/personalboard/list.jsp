<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp" %>


<section class="ftco-section">
    <div class="container">
        <div class="row no-gutters justify-content-center mb-5 pb-5">
            <div class="col-md-7 text-center heading-section ftco-animate">
                <span class="subheading">Works</span>
                <h2 class="mb-4">View our works below to see our design and way of development.</h2>
                <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live
                    the blind texts. Separated they live in</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header pb-0">
                    <h6>Personal Board List</h6>
                    <div align="right">
                        <button><a href="/personalboard/register">게시글등록</a></button>
                    </div>
                </div>
                <div class="card-body px-0 pt-0 pb-2">
                    <div class="table-responsive p-0">
                        <table class="table align-items-center mb-0">
                            <thead>
                            <tr>
                                <th hidden style="width: 20px">NUM</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                    Title
                                </th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    Content
                                </th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    Picture
                                </th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    RegDate
                                </th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    ModDate
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dtoList}" var="dto">
                                <td>
                                    <input type="hidden" name="bNum" value="${dto.bNum}">
                                    <c:set var="year" value="${fn:substring(dto.bRegDate, 0, 4)}"/>
                                    <c:set var="month" value="${fn:substring(dto.bRegDate, 6, 7)}"/>
                                    <c:set var="month1" value="${fn:substring(dto.bRegDate, 5, 7)}"/>
                                    <c:set var="date" value="${fn:substring(dto.bRegDate, 8, 10)}"/>
                                    <c:set var="year2" value="${fn:substring(dto.bModDate, 0, 4)}"/>
                                    <c:set var="month2" value="${fn:substring(dto.bModDate, 5, 7)}"/>
                                    <c:set var="date2" value="${fn:substring(dto.bModDate, 8, 10)}"/>

                                    <div class="d-flex px-2 py-1">
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 align="left" class="mb-0 text-sm"><a
                                                    href="javascript:moveRead(${dto.bNum})">${year}년 ${month}월 ${date}일의
                                                추억 </a></h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:set var="ct" value="${dto.content}"/>
                                    <c:set var="ct2" value="${fn:trim(ct)}"/>
                                    <c:if test="${fn:length(ct2) > 0}">

                                        <span class="text-xs font-weight-bold mb-0">Y</span>
                                    </c:if>
                                    <c:if test="${fn:length(ct2) == 0}">
                                        <span class="text-xs font-weight-bold mb-0">N</span>
                                    </c:if>
                                </td>

                                <td class="align-middle text-center text-sm">
                                    <span class="badge badge-sm bg-gradient-success">${dto.bPicCount}</span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="text-secondary text-xs font-weight-bold">${year}-${month1}-${date}</span>
                                </td>

                                <td class="align-middle text-center">
                                    <span class="text-secondary text-xs font-weight-bold">${year2}-${month2}-${date2}</span>
                                </td>


                                <td class="align-middle">
                                    <a href="javascript:;" class="text-secondary font-weight-bold text-xs"
                                       data-toggle="tooltip" data-original-title="Edit user">
                                        Edit
                                    </a>
                                </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

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
            </div>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col text-center">
            <div class="block-27">
                <ul>
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
</section>

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



<%@include file="../includes/footer.jsp" %>


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