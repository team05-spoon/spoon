/**
 * 1. 주소 팝업 열기 (기존 address.js 내용을 합침)
 */
function goPopup() {
    // 검색창 열 때 '주문자와 동일' 체크박스를 미리 해제
    const sameBox = document.getElementById("sameAsCustomer");
    if (sameBox) sameBox.checked = false;
    
    // 주소 팝업 창 호출 (경로는 서버 설정에 맞게 확인)
    window.open("/jusoPopup", "pop", "width=570, height=420, scrollbars=yes, resizable=yes");
}

/**
 * 2. 주소 팝업 콜백 함수
 */
function jusoCallBack(roadFullAddr, jibunAddr, zipNo) {
    const dAddrField = document.getElementById("d_addr");
    const zipField = document.getElementById("zipNo");
    const sameBox = document.getElementById("sameAsCustomer");

    // 배송지 주소 필드에 값 입력 (우편번호 포함 권장)
    if (dAddrField) dAddrField.value = "(" + zipNo + ") " + roadFullAddr;
    if (zipField) zipField.value = zipNo;

    // 체크박스 해제 확인
    if (sameBox) sameBox.checked = false;
}

/**
 * 3. 주문자 정보 -> 배송지 정보 복사
 */
function copyCustomerInfo() {
    const isChecked = document.getElementById("sameAsCustomer").checked;
    
    const oName = document.getElementById("o_name").value;
    const oTel = document.getElementById("o_tel").value;
    const oAddr = document.getElementById("o_addr").value;
    
    const dName = document.getElementById("d_name");
    const dTel = document.getElementById("d_tel");
    const dAddr = document.getElementById("d_addr");
    const zipNo = document.getElementById("zipNo");

    if (isChecked) {
        if(!oName.trim()) {
            alert("주문자 이름을 먼저 입력해주세요.");
            document.getElementById("sameAsCustomer").checked = false;
            return;
        }
        dName.value = oName;
        dTel.value = oTel;
        dAddr.value = oAddr;
        // 주문자 주소에 우편번호가 포함되어 있지 않다면 zipNo는 수동 입력 필요할 수 있음
    } else {
        dName.value = "";
        dTel.value = "";
        dAddr.value = "";
        zipNo.value = "";
    }
}

/**
 * 4. 유효성 검사 및 최종 확인
 */
function validateOrderForm() {
    const fields = [
        { id: "o_name", msg: "주문자 이름을 입력해주세요." },
        { id: "d_name", msg: "받는 분 이름을 입력해주세요." },
        { id: "d_addr", msg: "배송지 주소를 입력해주세요." },
        { id: "d_tel", msg: "배송지 전화번호를 입력해주세요." }
    ];

    for (let field of fields) {
        const el = document.getElementById(field.id);
        if (!el || el.value.trim() === "") {
            alert(field.msg);
            if(el) el.focus();
            return false;
        }
    }
    return confirm("결제를 진행하시겠습니까?");
}