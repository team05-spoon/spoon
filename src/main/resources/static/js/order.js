/**
 * 1. 주소 팝업 콜백 함수
 */
function jusoCallBack(roadFullAddr, jibunAddr, zipNo) {
    const dAddrField = document.getElementById("d_addr");
    const zipField = document.getElementById("zipNo");
    const sameBox = document.getElementById("sameAsCustomer");

    if (dAddrField) dAddrField.value = roadFullAddr;
    if (zipField) zipField.value = zipNo;

    // 주소를 새로 입력하면 '주문자와 동일' 체크박스를 해제해서 꼬이지 않게 함
    if (sameBox) sameBox.checked = false;
}

/**
 * 2. 주문자 정보 -> 배송지 정보 복사
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
    } else {
        dName.value = "";
        dTel.value = "";
        dAddr.value = "";
        zipNo.value = "";
    }
}

/**
 * 3. 유효성 검사
 */
function validateOrderForm() {
    const fields = [
        { id: "o_name", msg: "주문자 이름을 입력해주세요." },
        { id: "d_name", msg: "받는 분 이름을 입력해주세요." },
        { id: "d_addr", msg: "배송지 주소를 입력해주세요." }, // roadFullAddr를 d_addr로 수정
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