<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header2.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Read Page</h1>
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
            <div class="row">
                <!-- left column -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Board Read</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputEmail0">num</label>
                                <input type="text" name="bNum" class="form-control" id="exampleInputEmail0" value="<c:out value="${boardDTO.bNum}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Tag</label>
                                <input type="text" name="tag" class="form-control" id="exampleInputEmail1" value="<c:out value="${TagResponseDTO.tag}"></c:out>" readonly>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <!-- textarea -->
                                    <div class="form-group">
                                        <label>Textarea</label>
                                        <textarea name="content" class="form-control" rows="3" disabled><c:out value="${boardDTO.content}"></c:out>
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer float-right">
                            <button type="button" class="btn btn-default btnList">LIST</button>
                                <button type="button" class="btn btn-info btnMod">MODIFY</button>
                        </div>

                        <div>
                            <c:forEach items="${boardDTO.files}" var="attach">
                                <div>
                                    <c:if test="${attach.image}">
                                        <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/viewFile?file=${attach.getThumbnail()}">
                                    </c:if>
                                        ${attach.fileName}
                                </div>
                            </c:forEach>
                        </div>

                    </div>
                    <!-- /.card -->

                    </div>

                </div>
            </div>
    </section>
        </div>
</div>
<!-- /.content-wrapper -->

<form id="actionForm" action="/personalboard/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>

</form>

<div class="modal fade" id="modal-image">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <img id="targetImage">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<%@include file="../includes/footer2.jsp"%>

<script>
    const actionFrom = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click",()=> {actionFrom.submit()}, false)

    document.querySelector(".btnMod").addEventListener("click",()=> {

        const bNum = '${boardDTO.bNum}'

        actionFrom.setAttribute("action","/personalboard/modify")
        actionForm.innerHTML +=`<input type='hidden' name='bNum' value='\${bNum}'>`
        actionFrom.submit()
    }, false)

</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


<script>

    const modalImage = new bootstrap.Modal(document.querySelector('#modal-image'))

    function showOrigin(fileLink){


        document.querySelector("#targetImage").src = `/viewFile?file=\${fileLink}`
        modalImage.show()

    }

    function after(result){
        console.log("after............")
        console.log("result", result)
    }

    //doA().then(result => console.log(result))

    //doB(after)

    //const reply = {num:230, replyer:'user00', reply:'2222223333300000'}

    //doC(reply).then(result => console.log(result))

    //doD(112).then(result => console.log(result))

    //const reply = {rno:112, reply:"Update reply text..."}

    //doE(reply).then(result => console.log(result))



</script>

</body>
</html>