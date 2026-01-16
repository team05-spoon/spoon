package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.itemDTO;

@Mapper
public interface itemDAO {

	public List<itemDTO> listDao(String i_ctg); //상품목록보기
	public itemDTO viewDao(int i_no); //상품 상세보기
	public int writeDao(itemDTO dto); //상품등록
	public int deleteDao(int i_no); //상품 삭제
	public int updateDao(itemDTO dto);// 상품 수정
	public List<itemDTO> itemMyListDao(int s_no);
	public itemDTO findByiNo(int i_no);

}
