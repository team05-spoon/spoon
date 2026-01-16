
function submitUpdate() {
    var frm = document.sellerUpdateForm; // document.name 방식
    
    // 상호명 체크
    if(!frm.s_bn.value) { 
        alert("상호명을 입력해주세요.");
        frm.s_bn.focus();
        return false;
    }
    
    // 대표자명 체크
    if(!frm.s_name.value) {
        alert("대표자명을 입력해주세요.");
        frm.s_name.focus();
        return false;
    }

    if(confirm("정보를 수정하시겠습니까?")) {
        frm.submit();
    }
}


function checkRevoke(element) {
    var confirmStatus = window.confirm("해당 판매자의 권한을 회수하시겠습니까?");
    if (confirmStatus) {
        return true;
    } else {
        return false;
    }
}

/**
 * 판매자 반려(삭제) 확인 함수
 */
function confirmDelete() {
    // 반려 버튼 클릭 시 띄울 문구
    const message = "해당 판매자 신청을 반려(삭제)하시겠습니까?";
    
    // confirm 창에서 '확인'을 누르면 true, '취소'를 누르면 false 반환
    return confirm(message);
}

/**
 * 2. 판매자 정보 수정 유효성 검사 (Update)
 */
function validateUpdateForm() {
    var f = document.sellerUpdateForm;

    if (f.s_name.value.trim().length < 2 || f.s_name.value.trim().length > 10) {
        alert("대표자명은 2~10자 이내로 입력해주세요.");
        f.s_name.focus();
        return false;
    }

    if (f.s_bn.value.trim().length < 2) {
        alert("사업장명을 2자 이상 입력해주세요.");
        f.s_bn.focus();
        return false;
    }

    // [수정] numValue 변수를 추출하는 로직이 빠져있었습니다.
    var numValue = f.s_num.value.replace(/[^\d]/g, ""); 
    f.s_num.value = numValue; 

    if (numValue.length !== 10) {
        alert("사업자 등록번호는10자리로 입력해주세요.");
        f.s_num.focus();
        return false;
    }

    return confirm("정보를 수정하시겠습니까?");
}

/**
 * 탈퇴(삭제) 확인 함수
 */
function confirmDelete() {
    return confirm("정말로 탈퇴하시겠습니까? 모든 정보가 삭제됩니다.");
}

/**
 * 판매자 승인 처리 최종 확인
 */
function confirmApprove() {
    var frm = document.approveFrm;
    var selectedRole = frm.s_temp.value; // 선택된 권한 값 가져오기
    
    var msg = "";
    if(selectedRole === "SELLER") {
        msg = "해당 유저를 정식 '판매자'로 승인하시겠습니까?";
    } else {
        msg = "권한을 '일반 유저' 상태로 유지하시겠습니까?";
    }

    if (confirm(msg)) {
        return true;
    } else {
        return false;
    }
}

/**
 * 상세보기 페이지에서 탈퇴(삭제) 확인
 */
function confirmDeleteView(s_no) {
    if (confirm("정말로 이 판매자를 탈퇴 처리하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
        // 확인을 누르면 삭제 URL로 이동
        location.href = "/seller/sellerdelete?s_no=" + s_no;
    }
}

/**
 * 판매자 가입 신청 유효성 검사 (Write)
 */
function validateWriteForm() {
    var f = document.sellerwriteForm;

    if (f.s_name.value.trim().length < 2 || f.s_name.value.trim().length > 10) {
        alert("대표자명은 2~10자 이내로 입력해주세요.");
        f.s_name.focus();
        return false;
    }

    if (f.s_bn.value.trim().length < 2) {
        alert("사업장명(상호명)을 2자 이상 정확히 입력해주세요.");
        f.s_bn.focus();
        return false;
    }

    // [수정] 숫자만 추출하는 로직 보강
    var numValue = f.s_num.value.replace(/[^\d]/g, ""); 
    f.s_num.value = numValue;

    if (numValue.length !== 10) {
        alert("사업자 등록번호는 숫자10자리로 입력해주세요.");
        f.s_num.focus();
        return false;
    }

    return confirm("판매자 신청을 진행하시겠습니까?\n관리자 승인 후 판매 활동이 가능합니다.");
}