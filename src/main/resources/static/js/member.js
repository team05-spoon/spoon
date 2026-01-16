/**
 * 1. 회원 탈퇴 확인 (관리자용)
 */
function confirmMemberDelete(m_no, m_id, contextPath) {
    if (confirm("아이디 [" + m_id + "] 회원을 탈퇴 처리하시겠습니까?\n이 작업은 취소할 수 없습니다.")) {
        location.href = contextPath + "/member/memberdelete?m_no=" + m_no;
    }
}

/**
 * 2. 로그인 페이지 유효성 검사 및 자동 포커스
 */
document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.querySelector("form[action*='security_check']");
    
    if (loginForm) {
        const usernameInput = document.getElementById("m_username");
        const passwordInput = document.getElementById("m_password");
        
        // 아이디 입력창 자동 포커스
        if(usernameInput) usernameInput.focus();

        loginForm.onsubmit = function() {
            // 회원가입 규칙과 동일한 정규표현식 적용
            const expId = /^[A-Za-z0-9]{4,12}$/;           // 아이디: 영문/숫자 4~12자리
            const expPw = /^[A-Za-z0-9!@#$%_]{8,12}$/;     // 비밀번호: 영문/숫자/특수문자 8~12자리

            // 1. 아이디 검사
            if (usernameInput.value.trim() === "") {
                alert("아이디를 입력해주세요.");
                usernameInput.focus();
                return false;
            }
            if (!expId.test(usernameInput.value)) {
                alert("아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다.\n형식에 맞게 입력 후 다시 시도해주세요.");
                usernameInput.focus();
                return false;
            }

            // 2. 비밀번호 검사
            if (passwordInput.value.trim() === "") {
                alert("비밀번호를 입력해주세요.");
                passwordInput.focus();
                return false;
            }
            if (!expPw.test(passwordInput.value)) {
                alert("비밀번호는 8~12자의 영문, 숫자, 특수문자(!@#$%_)만 가능합니다.\n형식을 확인해주세요.");
                passwordInput.focus();
                return false;
            }

            // 모든 검사 통과 시 버튼 시각적 효과
            const btn = document.querySelector(".btn-login");
            if(btn) {
                btn.innerText = "로그인 중...";
                btn.style.opacity = "0.7";
            }
            return true;
        };
    }
});

/**
 * 회원 정보 수정 유효성 검사 (Update)
 */
function validateUpdate() {
    const form = document.member;

    // 정규표현식 (회원가입과 동일하게 유지하여 일관성 제공)
    const expPw = /^[A-Za-z0-9!@#$%_]{8,12}$/;     // 비밀번호: 8~12자리
    const expTel = /^[0-9]{10,11}$/;               // 전화번호: 숫자만 10~11자리
    const expEmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/; // 이메일 형식

	// 1. 비밀번호 체크 (입력값이 있을 때만 형식 검사 실행)
	if (form.m_pw.value.trim().length > 0) { 
	    // 비밀번호란에 무언가 입력했다면?
	    if (!expPw.test(form.m_pw.value)) {
	        // 그런데 형식이 맞지 않다면?
	        alert("비밀번호는 8~12자의 영문, 숫자, 특수문자(!@#$%_)만 가능합니다.");
	        form.m_pw.focus();
	        return false;
	    }
	}
	// 입력값이 없다면(0이라면) 검사를 건너뛰고 다음 단계(전화번호 체크)로 넘어갑니다.

    // 2. 전화번호 체크
    const telValue = form.m_tel.value.replace(/-/g, ""); // 하이픈 제거 후 검사
    if (!telValue || !expTel.test(telValue)) {
        alert("전화번호는 10~11자리의 숫자만 입력 가능합니다.");
        form.m_tel.focus();
        return false;
    }

    // 3. 이메일 체크
    if (!form.m_email.value || !expEmail.test(form.m_email.value.toLowerCase())) {
        alert("올바른 이메일 형식이 아닙니다. (예: example@farm.com)");
        form.m_email.focus();
        return false;
    }

    // 4. 주소 체크 (비어있는지 확인)
    if (form.m_addr.value.trim() === "") {
        alert("주소를 입력해주세요.");
        form.m_addr.focus();
        return false;
    } 

    return confirm("입력하신 정보로 수정을 진행하시겠습니까?");
}

/**
 * 회원가입 유효성 검사 (FARM PEOPLE 스타일)
 */
function validateMemberWrite() {
    const form = document.memberwriteForm;

    // 정규표현식 설정
    const expId = /^[A-Za-z0-9]{4,12}$/;           // 아이디: 영문/숫자 4~12자리
    const expPw = /^[A-Za-z0-9!@#$%_]{8,12}$/;     // 비밀번호: 영문/숫자/특수문자 8~12자리
    const expName = /^[가-힣]{2,5}$/;              // 이름: 한글 2~5글자
    const expTel = /^[0-9]{10,11}$/;               // 전화번호: 숫자만 10~11자리
    const expEmail = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/; // 이메일 형식

    // 1. 아이디 체크
    if (!form.m_id.value || !expId.test(form.m_id.value)) {
        alert("아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다.");
        form.m_id.focus();
        return false;
    }

    // 2. 비밀번호 체크
    if (!form.m_pw.value || !expPw.test(form.m_pw.value)) {
        alert("비밀번호는 8~12자의 영문, 숫자, 특수문자(!@#$%_)만 가능합니다.");
        form.m_pw.focus();
        return false;
    }

    // 3. 이름 체크
    if (!form.m_name.value || !expName.test(form.m_name.value)) {
        alert("이름은 한글 2~5자 이내로 입력해주세요.");
        form.m_name.focus();
        return false;
    }

    // 4. 전화번호 체크 (하이픈 제거 후 숫자만 체크)
    const telValue = form.m_tel.value.replace(/-/g, ""); // 사용자가 혹시 -를 넣었을 경우 제거
    if (!telValue || !expTel.test(telValue)) {
        alert("전화번호는 10~11자리의 숫자만 입력 가능합니다.");
        form.m_tel.focus();
        return false;
    }

    // 5. 이메일 체크
    if (!form.m_email.value || !expEmail.test(form.m_email.value.toLowerCase())) {
        alert("올바른 이메일 형식이 아닙니다. (예: example@farm.com)");
        form.m_email.focus();
        return false;
    }

    // 6. 주소 체크 (우편번호 검색 여부 확인)
    if (form.m_zip.value === "" || form.m_addr.value === "") {
        alert("우편번호 검색을 통해 주소를 입력해주세요.");
        return false;
    }

    // 7. 생일 체크
    if (form.m_birth.value === "") {
        alert("생년월일을 선택해주세요.");
        form.m_birth.focus();
        return false;
    }

    return confirm("회원가입을 완료하시겠습니까?");
}