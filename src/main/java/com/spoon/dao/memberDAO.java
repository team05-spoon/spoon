package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.memberDTO;

@Mapper
public interface memberDAO {

	public List<memberDTO> listDao();
	public memberDTO viewDao(int m_no);
	public int writeDao(memberDTO dto);
	public int deleteDao(int m_no);
	public int updateDao(memberDTO dto);
	public memberDTO findByMid(String m_id);
	public memberDTO findByMno(int m_no);
	
}
