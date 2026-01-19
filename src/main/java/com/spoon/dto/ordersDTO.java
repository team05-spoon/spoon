package com.spoon.dto;

import java.util.Date;

import lombok.Data;

@Data	
public class ordersDTO {

	private long o_no;
	private long o_tp;
	private Date o_date;
	private String o_name;
	private String o_addr;
	private String o_tel;
	private String d_name;
	private String d_addr;
	private String d_tel;
	private int m_no;
	private int i_no;
	private int c_count;
	private long c_price;

}
