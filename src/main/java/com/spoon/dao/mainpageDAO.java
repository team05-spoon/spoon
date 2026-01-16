package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.NoticeDTO;
import com.spoon.dto.itemDTO;

@Mapper
public interface mainpageDAO {

    // 신규 상품
    List<itemDTO> newItems();

    // 추천 상품
    List<itemDTO> bestItems();

    // 공지사항 최신글
    List<NoticeDTO> noticeTop();
}
