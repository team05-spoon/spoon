package com.spoon.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class sellerDTO {
	private int s_no;
	private String s_name;
	private String s_bn;
	private long s_num;
	private String s_temp;
	private int m_no;
}
