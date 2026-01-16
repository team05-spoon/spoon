/**
 * FARM PEOPLE - 공통 주소 검색 스크립트
 */

// 1. 주소 검색 팝업 열기
function goPopup() {
    // 주소 팝업 창을 띄웁니다.
    window.open("/jusoPopup", "pop", "width=570, height=420, scrollbars=yes, resizable=yes");
}

// 2. 팝업에서 주소를 선택했을 때 실행되는 콜백 함수
function jusoCallBack(roadFullAddr, zipNo) {
    // 우편번호와 주소 필드가 존재하는지 확인 후 값 세팅
    var zipInput = document.getElementById("zipNo");
    var addrInput = document.getElementById("roadFullAddr");

    if (zipInput) {
        zipInput.value = zipNo;
    }

    if (addrInput) {
        // DTO 변수 추가 없이 관리하기 위해 (우편번호) 주소 형태로 합쳐서 저장
        addrInput.value = "(" + zipNo + ") " + roadFullAddr;
    }
}