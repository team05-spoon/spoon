/**
 * 주문자 정보를 배송지 정보로 복사
 */
/**
 * 주문자 정보를 배송지 정보로 복사
 */
function copyCustomerInfo() {
    // 체크박스 상태 확인
    const isChecked = document.getElementById("sameAsCustomer").checked;
    
    // 복사할 원본 데이터 (주문자)
    const oName = document.getElementById("o_name").value;
    const oTel = document.getElementById("o_tel").value;
    const oAddr = document.getElementById("o_addr").value;
    
    // 대상 데이터 (배송지)
    const dName = document.getElementById("d_name");
    const dTel = document.getElementById("d_tel");
    const dAddr = document.getElementById("d_addr");

    if (isChecked) {
        // 값이 비어있을 경우 경고 (선택 사항)
        if(!oName.trim()) {
            alert("주문자 이름을 먼저 입력해주세요.");
            document.getElementById("sameAsCustomer").checked = false;
            return;
        }
        dName.value = oName;
        dTel.value = oTel;
        dAddr.value = oAddr;
    } else {
        // 체크 해제 시 초기화
        dName.value = "";
        dTel.value = "";
        dAddr.value = "";
    }
}

/**
 * 주문 전 최종 유효성 검사
 */
function validateOrderForm() {
    const requiredFields = [
        { id: "o_name", msg: "주문자 이름을 입력해주세요." },
        { id: "d_name", msg: "받는 사람 이름을 입력해주세요." },
        { id: "d_addr", msg: "배송지 주소를 입력해주세요." },
        { id: "d_tel", msg: "배송지 전화번호를 입력해주세요." }
    ];

    for (let field of requiredFields) {
        const element = document.getElementById(field.id);
        if (element.value.trim() === "") {
            alert(field.msg);
            element.focus();
            return false;
        }
    }

    return confirm("실제 결제를 진행하시겠습니까?");
}

/**
 * FARM PEOPLE 주문 목록 스크립트
 */
document.addEventListener("DOMContentLoaded", function() {
    
    // 1. 테이블의 행(tr) 클릭 시 상세 페이지로 이동
    const orderRows = document.querySelectorAll(".order-product-table tbody tr");
    
    orderRows.forEach(row => {
        // "주문 내역이 없습니다" 행은 제외
        if (!row.querySelector("td[colspan]")) {
            row.addEventListener("click", function(e) {
                // 만약 클릭한 요소가 이미 <a> 태그라면 중복 이동 방지
                if (e.target.tagName !== 'A') {
                    const detailLink = this.querySelector("td:first-child a");
                    if (detailLink) {
                        window.location.href = detailLink.href;
                    }
                }
            });
        }
    });

    // 2. 총 누적액이 0원일 경우 요약 박스 숨기기 (선택 사항)
    const summaryBox = document.querySelector(".order-summary-box strong");
    if (summaryBox && summaryBox.innerText.startsWith("0")) {
        // 데이터가 아예 없을 때는 요약 박스를 숨길 수 있습니다.
        // document.querySelector(".order-summary-box").style.display = "none";
    }
});
