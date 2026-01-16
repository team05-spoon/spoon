package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.cartDTO;

@Mapper
public interface cartDAO {

	public List<cartDTO> listDao(int m_no);
	public cartDTO viewDao(int c_no);
	public int writeDao(cartDTO dto);
	public int deleteDao(int c_no);
	public int updateDao(cartDTO dto);
	public int cleancart(int m_no);
}
