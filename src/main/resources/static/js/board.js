/* board.js */

// 삭제 확인 함수
function delCheck() {
    return confirm("정말 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.");
}


// 수정 폼 유효성 검사
function editCheck() {
    var f = document.editForm;
    
    if (f.b_title.value.trim() == "") {
        alert("제목을 입력해주세요.");
        f.b_title.focus();
        return false;
    }
    
    if (f.b_memo.value.trim() == "") {
        alert("내용을 입력해주세요.");
        f.b_memo.focus();
        return false;
    }

    return confirm("수정된 내용을 저장하시겠습니까?");
}

/* list */

// 목록 페이지 행 클릭 및 호버 효과 초기화 함수
function initBoardList() {
    var rows = document.querySelectorAll(".board-table tbody tr");
    rows.forEach(function(row) {
        row.style.cursor = "pointer";
        
        // 클릭 시 상세 이동
        row.onclick = function(e) {
            if (e.target.tagName !== 'A') {
                var anchor = this.querySelector(".title-cell a");
                if (anchor) {
                    location.href = anchor.href;
                }
            }
        };
        
        // 호버 배경색 변경
        row.onmouseover = function() { this.style.backgroundColor = "#f8f9fa"; };
        row.onmouseout = function() { this.style.backgroundColor = "transparent"; };
    });
}

/* write */

// 새 글 작성 유효성 검사
function boardCheck() {
    var f = document.boardForm;

    if (f.b_title.value.trim().length < 2) {
        alert("제목을 2자 이상 입력해 주세요.");
        f.b_title.focus();
        return false; 
    }

    if (f.b_memo.value.trim().length < 5) {
        alert("내용을 5자 이상 상세히 입력해 주세요.");
        f.b_memo.focus();
        return false;
    }

    if (!confirm("게시글을 등록하시겠습니까?")) {
        return false;
    }
    
    return true; 
}