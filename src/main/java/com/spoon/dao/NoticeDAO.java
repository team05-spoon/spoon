package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.NoticeDTO;

@Mapper
public interface NoticeDAO {

    // 공지사항 목록
    public List<NoticeDTO> findAll();

    // 공지사항 상세
    public NoticeDTO findByNo(Long n_no);

    // 공지사항 등록
    public int insert(NoticeDTO dto);

    // 공지사항 삭제
    public int delete(Long n_no);
    
    // 공지사항 수정
    public int update(NoticeDTO dto);
}
