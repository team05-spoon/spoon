package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.BoardDTO;

@Mapper
public interface BoardDAO {

    // 게시글 목록
    public List<BoardDTO> findAll();

    // 게시글 상세
    public BoardDTO findByNo(Long b_no);

    // 게시글 등록
    public int insert(BoardDTO dto);

    // 게시글 수정
    public int update(BoardDTO dto);

    // 게시글 삭제
    public int delete(Long b_no);
}
