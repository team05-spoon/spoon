package com.spoon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spoon.dto.ordersDTO;

@Mapper
public interface ordersDAO {

	public long writeDao(ordersDTO dto);
	public void completeDao(ordersDTO dto);
	public List<ordersDTO> listDao(int m_no);
	public ordersDTO viewDao(long o_no);
}
