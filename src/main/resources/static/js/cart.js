/* cart.js */

// 1. 삭제 전 한 번 더 물어보기 (기존 인라인 코드를 함수로 분리)
function confirmDelete() {
    return confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?");
}

// 2. 빈 장바구니로 주문 진행 차단
function checkOrder(itemCount) {
    if (itemCount <= 0) {
        alert("장바구니에 담긴 상품이 없습니다.");
        return false;
    }
    return confirm("주문 페이지로 이동하시겠습니까?");
}

// 3. (심화) 수량 변경 시 합계 자동 계산 기능 (필요시 HTML 구조 수정 후 사용)
// 현재는 단순히 확인 메시지만 띄우는 용도로 사용 가능합니다.