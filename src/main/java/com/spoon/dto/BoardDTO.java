package com.spoon.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
  private Long b_no;
  private String b_title;
  private String b_write;
  private String b_memo;
  private Date b_date;
  private int m_no;
}
