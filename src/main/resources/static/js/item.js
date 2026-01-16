/* item.js */

function initItemCard() {
    const cards = document.querySelectorAll('.item-card');
    
    cards.forEach(card => {
        card.addEventListener('click', function() {
            // 카드 내부에 숨겨진 링크나 상품 ID를 이용해 이동
            const link = this.querySelector('.item-name-link').getAttribute('href');
            location.href = link;
        });
    });
}

/* memberview */

// 장바구니 담기 확인
function addCartCheck() {
    const qty = document.getElementById("quantity").value;
    return confirm(qty + "개의 상품을 장바구니에 담으시겠습니까?");
}

// 수량 변경 시 실시간 총 금액 계산 (선택 사항)
function updateTotalPrice(price) {
    const qty = document.getElementById("quantity").value;
    const total = price * qty;
    const display = document.getElementById("total-display");
    if(display) {
        display.innerText = total.toLocaleString() + "원";
    }
}

/* itemsellerview */

// 판매자용 상품 삭제 확인
function sellerDeleteCheck(itemNo) {
    if (confirm("등록하신 상품을 정말 삭제하시겠습니까?\n삭제된 상품은 상점 목록에서 즉시 제거됩니다.")) {
        location.href = "/item/delete?i_no=" + itemNo;
    }
}

/* update */

function itemUpdateCheck() {
    const f = document.itemUpdateForm;

    // 가격 유효성 검사 (숫자만)
    if (isNaN(f.i_price.value) || f.i_price.value.trim() === "") {
        alert("가격은 숫자만 입력 가능합니다.");
        f.i_price.focus();
        return false;
    }

    return confirm("수정된 내용을 저장하시겠습니까?");
}

/* itemwrite */

/**
 * FARM PEOPLE - 상품 등록 유효성 검사 (item.js)
 */
function validateItemForm() {
    // 폼 객체를 변수에 할당 (document.폼이름)
    var form = document.itemWriteForm;
	

    // 1. 상품명 체크 (추천 로직 포함)
    var itemName = form.i_name.value.trim();
    if (itemName === "") {
        alert("상품명을 입력해주세요.");
        form.i_name.focus();
        return false;
    }

    // 2. 가격 체크
    var itemPrice = form.i_price.value.trim();
    if (itemPrice === "") {
        alert("가격을 입력해주세요.");
        form.i_price.focus();
        return false;
    }
    if (isNaN(itemPrice)) {
        alert("가격은 숫자만 입력 가능합니다.");
        form.i_price.value = "";
        form.i_price.focus();
        return false;
    }
	
	var itemOption = form.i_option.value.trim();
	    if (itemOption === "") {
	        alert("옵션 정보(예: 5kg 1박스)를 입력해주세요.");
	        form.i_option.focus();
	        return false;
	    }

    // 3. 파일 체크 (이미지 필수 등록 확인)
    if (form.i_tfile.value === "") {
        alert("메인 이미지(썸네일)를 등록해주세요.");
        return false;
    }
    if (form.i_dfile.value === "") {
        alert("상세 페이지 이미지를 등록해주세요.");
        return false;
    }

    // 4. 카테고리 체크 (선택 상태 " " 인 경우 주문/등록 불가)
    // JSP에서 <option value=" ">선택</option> 으로 되어 있으므로 아래와 같이 체크합니다.
    if (form.i_ctg.value === " ") {
        alert("카테고리를 선택해주세요.");
        form.i_ctg.focus();
        return false;
    }

    // 5. 상세 설명 체크
    if (form.i_ex.value.trim() === "") {
        alert("상세 설명을 입력해주세요.");
        form.i_ex.focus();
        return false;
    }

    // 최종 확인
    return confirm("작성하신 내용으로 상품을 등록하시겠습니까?");
}

/* myitem */

// 내 상품 목록에서 즉시 삭제 확인
function deleteMyItem(itemNo) {
    if(confirm("해당 상품을 정말로 내 상점에서 삭제하시겠습니까?\n삭제된 상품은 복구할 수 없습니다.")) {
        location.href = "/item/delete?i_no=" + itemNo;
    }
}

function toggleDetail() {
        const detailSection = document.getElementById('detail-section');
        const btn = document.querySelector('.btn-detail-view');

        if (detailSection.style.display === 'none') {
            // 보이기
            detailSection.style.display = 'block';
            btn.innerText = '상세내용 닫기 ↑';
            // 부드럽게 해당 위치로 이동
            detailSection.scrollIntoView({ behavior: 'smooth' });
        } else {
            // 숨기기
            detailSection.style.display = 'none';
            btn.innerText = '상품 상세내용 보기 ↓';
            // 닫을 때는 다시 위로 살짝 이동 (옵션)
            window.scrollTo({ top: 100, behavior: 'smooth' });
        }
    }