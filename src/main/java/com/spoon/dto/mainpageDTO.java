package com.spoon.dto;

import java.util.List;

import lombok.Data;

@Data
public class mainpageDTO {

    // 신규 상품
    private List<itemDTO> newItems;

    // 추천 상품
    private List<itemDTO> bestItems;

    // 공지사항 최신글
    private List<NoticeDTO> noticeTop;
}
