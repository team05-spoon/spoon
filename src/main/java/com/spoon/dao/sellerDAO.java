package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.sellerDTO;

@Mapper
public interface sellerDAO {

	public List<sellerDTO> listDao(); //목록보기
	public sellerDTO viewDao(int s_no); // 상세보기
	public int writeDao(sellerDTO dto); //등록
	public int deleteDao(int s_no); // 삭제
	public int updateDao(sellerDTO dto);//  수정
	
	public sellerDTO getSellerByMemberNo(int m_no);
	public sellerDTO findByMemberNo(int m_no);
}
