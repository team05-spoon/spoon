/* detail */

// 공지사항 삭제 확인
function noticeDelCheck() {
    return confirm("이 공지사항을 정말 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.");
}

/* edit */

// 공지사항 수정 유효성 검사
function noticeEditCheck() {
    var f = document.noticeEditForm;
    
    if (f.n_title.value.trim() == "") {
        alert("공지 제목을 입력해 주세요.");
        f.n_title.focus();
        return false;
    }
    
    if (f.n_nb.value.trim() == "") {
        alert("공지 내용을 입력해 주세요.");
        f.n_nb.focus();
        return false;
    }

    return confirm("공지사항을 이대로 수정하시겠습니까?");
}

/* list */

// 공지사항 목록 행 클릭 이벤트 초기화
function initNoticeList() {
    var rows = document.querySelectorAll(".notice-table tbody tr");
    rows.forEach(function(row) {
        row.style.cursor = "pointer";
        row.onclick = function(e) {
            // 클릭한 요소가 링크(A)가 아닐 때만 작동
            if (e.target.tagName !== 'A') {
                var link = this.querySelector(".title-cell a").href;
                location.href = link;
            }
        };
        // 마우스 호버 효과
        row.onmouseover = function() { this.style.backgroundColor = "#fafafa"; };
        row.onmouseout = function() { this.style.backgroundColor = "transparent"; };
    });
}

/* write */

// 공지사항 등록 유효성 검사
function check() {
    let f = document.noticeForm;

    if (f.n_title.value.trim().length < 2) {
        alert("제목을 2자 이상 입력해 주세요.");
        f.n_title.focus();
        return false;
    }

    if (f.n_nb.value.trim().length < 5) {
        alert("공지 내용을 5자 이상 상세히 입력해 주세요.");
        f.n_nb.focus();
        return false;
    }

    if (!confirm("이 내용을 공지사항으로 등록하시겠습니까?")) {
        return false;
    }

    // 전송 시에는 이탈 방지 경고 끔
    window.onbeforeunload = null;
    return true;
}

// 이탈 방지 로직 초기화 함수
function initWriteForm() {
    let isChange = false;
    const form = document.noticeForm;

    if (form) {
        form.oninput = function() {
            isChange = true;
        };
    }

    window.onbeforeunload = function() {
        if (isChange) {
            return "작성 중인 내용이 저장되지 않을 수 있습니다.";
        }
    };
}