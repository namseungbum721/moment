<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp" %>

<%--<link rel="stylesheet" href="/resources/assets/css/soft-ui-dashboard.css">--%>


<section class="ftco-section contact-section ftco-degree-bg">
    <div class="container bg-light">
        <div class="row d-flex mb-6 contact-info">
            <div class="col-md-12 mb-4">
                <h2 class="h4">Register Page</h2>
            </div>
            <div class="w-100"></div>
            <form id="form1" action="/personalboard/register" method="post">
                <div class="col-md-12 mb-4">
                    <p class="h5">
                        <script>let today = new Date();

                        let year = today.getFullYear(); // 년도
                        let month = today.getMonth() + 1;  // 월
                        let date = today.getDate();  // 날짜
                        let day = today.getDay();  // 요일

                        document.write(year + '년 ' + month + '월 ' + date + '일의 추억')</script>
                    </p>
                </div>
                <div class="row block-9">

                    <div class="col-md-12 pr-md-5">

                        <div class="form-group">
                            <input type="text" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." style="width: 300px;"/>
                        </div>

                        <div class="form-group">
                            <input type="hidden" value="" name="tag" id="rdTag"/>
                        </div>

                        <ul id="tag-list">

                        </ul>

                        <div class="form-group">
                            <span>Content</span><textarea name="content" cols="30" rows="7" class="form-control"
                                                          placeholder="Content"></textarea>
                        </div>

                    </div>

                    <div class="map_wrap">
                        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

                        <div id="menu_wrap" class="bg_white">
                            <div class="option">
                                <div>
                                    키워드 : <input type="text" value="서울역" id="keyword" size="15">
                                    <button onclick="searchPlaces(); return false;">검색하기</button>
                                </div>
                            </div>
                            <hr>
                            <ul id="placesList"></ul>
                            <div id="pagination"></div>
                        </div>
                    </div>
                    <div>
                        <!-- 위도 및 경도 좌표 및 위치정보 -->
                        <input type="text" id="fulladdress" name="fulladdress" style="width:100%;" disabled readonly>
                        <input type="text" id="pName" name="pName" value="" readonly>
                        <input type="text" id="pAddress" name="pAddress" value="" readonly>
                        <input type="text" id="pLat" name="pLat" value="" readonly>
                        <input type="text" id="pLng" name="pLng" value="" readonly>
                    </div>
                </div>
                <div class="temp"></div>
                <div class="card-footer">
                    <button type="button" id="submitBtn" class="btn btn-primary">Submit</button>
                </div>
                <h2 class="title">File Upload</h2>
            </form>


            <style>
                .uploadResult {
                    display: flex;
                    justify-content: center;
                    flex-direction: row;
                }
            </style>


            <div class="input-group">

                <div class="custom-file">
                    <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile"
                           multiple>
                    <label class="custom-file-label" for="exampleInputFile">File</label>
                </div>
                <div class="input-group-append">
                    <span class="input-group-text" id="uploadBtn">Upload</span>
                </div>
            </div>

            <div class="uploadResult">

            </div>
        </div>
    </div>

</section>


<%@include file="../includes/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


<script>
    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click", (e) => {

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for (let i = 0; i < fileInput.files.length; i++) {

            //console.log(fileInput.files[i])

            formData.append("uploadFiles", fileInput.files[i])
        }

        console.log(formData)

        const headerObj = {headers: {'Content-Type': 'multipart/form-data'}}

        axios.post("/upload", formData, headerObj).then((response) => {
            const arr = response.data
            console.log(arr)
            let str = ""
            for (let i = 0; i < arr.length; i++) {
                const {uuid, fileName, uploadPath, image, thumbnail, fileLink} = {...arr[i]}

                if (image) {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}' ><img src='/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this)" >x</button></div>`
                } else {
                    str += `<div data-uuid='\${uuid}'data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/downFile?file=\${fileLink}'>\${fileName}</a></div>`
                }


            }//end for
            uploadResultDiv.innerHTML += str

        })


    }, false)


    function removeFile(fileLink, ele) {
        console.log(fileLink)
        axios.post("/removeFile", {fileName: fileLink}).then(response => {
            const targetDiv = ele.parentElement
            targetDiv.remove()
        })
    }


    //태그구현
    $(document).ready(function () {

        var tag = {};
        var counter = 0;

        // 태그를 추가한다.
        function addTag(value) {
            tag[counter] = value; // 태그를 Object 안에 추가
            counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
        }

        // 최종적으로 서버에 넘길때 tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
        function marginTag() {
            return Object.values(tag).filter(function (word) {
                return word !== "";
            });
        }


        document.querySelector("#submitBtn").addEventListener("click", (e) => {
            //1.submitbtn합체 ( 기존 tag에 값이 안담김 )
            //2.tag 관련 히든태그 변경, EL 안먹혔었음.
            //3.name의 변수명 변경 -> tag->tags[i].tag
            e.stopPropagation()
            e.preventDefault()
            //현재 화면에 있는 파일 정보를 hidden태그들로 변화
            const form1 = document.querySelector("#form1")
            const fileDivArr = uploadResultDiv.querySelectorAll("div")
            var value = marginTag(); // return array

            console.log("---------------------------")
            console.log(value)

            alert(value)

            let strtag = "";

            for (var i = 0; i < value.length; i++) {
                strtag += `<input type='hidden' name='tags[\${i}].tag' value='\${value[i]}'>`
            }

            console.log(strtag);

            $("#rdTag").html(strtag);

            $(this).submit();

            if (!fileDivArr) {

                form1.submit()

                return
            }

            let str = "";
            for (let i = 0; i < fileDivArr.length; i++) {
                const target = fileDivArr[i]
                const uuid = target.getAttribute("data-uuid")
                const fileName = target.getAttribute("data-filename")
                const uploadPath = target.getAttribute("data-uploadpath")
                const image = target.getAttribute("data-image")

                str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}' >`
                str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}' >`
                str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}' >`
                str += `<input type='hidden' name='files[\${i}].image' value='\${image}' >`
            }

            document.querySelector(".temp").innerHTML = str
            //form1.innerHTML += str
            console.log(tag + "tag")
            console.log(tag[0] + "tag0번째")
            form1.submit()
            //form을 submit

        }, false)

        $("#tag").on("keypress", function (e) {
            var self = $(this);

            // input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
            if (e.key === "Enter" || e.keyCode == 32) {

                var tagValue = self.val(); // 값 가져오기

                // 값이 없으면 동작 ㄴㄴ
                if (tagValue !== "") {

                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                    var result = Object.values(tag).filter(function (word) {
                        return word === tagValue;
                    })

                    // 태그 중복 검사
                    if (result.length == 0) {
                        $("#tag-list").append("<li class='tag-item'>" + tagValue + "<span class='del-btn' idx='" + counter + "'>x</span></li>");
                        addTag(tagValue);
                        self.val("");
                    } else {
                        alert("태그값이 중복됩니다.");
                    }
                }
                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
            }
        });

        // 삭제 버튼
        // 삭제 버튼은 비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
        $(document).on("click", ".del-btn", function (e) {
            var index = $(this).attr("idx");
            tag[index] = "";
            $(this).parent().remove();
        });
    })

</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be49d75a3ddca2d7f6dfda5c02603d87&libraries=services"></script>


<!-- map -->
<script>

    // 마커를 담을 배열입니다
    var markers = [];

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

    // 키워드로 장소를 검색합니다
    searchPlaces();

    // 키워드 검색을 요청하는 함수입니다
    function searchPlaces() {

        var keyword = document.getElementById('keyword').value;

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }

        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch(keyword, placesSearchCB);
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function (marker, pName, pAddressress, pAddress, pLat, pLng) {
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, pName);
                });

                kakao.maps.event.addListener(map, 'mouseout', function () {
                    infowindow.close();
                });

                // 리스트의 아이템을 클릭하면 정보들을 hidden 영역으로 전송
                itemEl.onclick = function () {
                    if (pAddressress) {
                        document.getElementById('fulladdress').value = "[" + pName + "]" + pAddressress;
                    } else {
                        document.getElementById('fulladdress').value = "[" + pName + "]" + pAddress;
                    }

                    document.getElementById('pName').value = pName;
                    if (pAddressress) {
                        document.getElementById('pAddress').value = pAddressress;
                    } else {
                        document.getElementById('pAddress').value = pAddress;
                    }
                    document.getElementById('pLat').value = pLat;
                    document.getElementById('pLng').value = pLng;
                };

                itemEl.onmouseover = function () {
                    displayInfowindow(marker, pName);
                };

                itemEl.onmouseout = function () {
                    infowindow.close();
                };
            })(marker, places[i].place_name, places[i].road_address_name, places[i].address_name, places[i].y, places[i].x);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {

        var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info" style="cursor:pointer;">' +
                '   <h5>' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>' +
                '   <span class="jibun gray">' + places.address_name + '</span>';
        } else {
            itemStr += '    <span>' + places.address_name + '</span>';
        }
        itemStr += '  <span class="tel">' + places.phone + '</span>';
        +
            '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        return el;
    }


    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }

</script>
</body>
</html>