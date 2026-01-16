package com.spoon.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class itemDTO {

	private int i_no;
	private String i_name;
	private String i_price;
	private MultipartFile i_tfile;
	private String i_timage;
	private MultipartFile i_dfile;
	private String i_dimage;
	private String i_option;
	private String i_ctg;
	private String i_ex;
	private int s_no;
	private int m_no;
}