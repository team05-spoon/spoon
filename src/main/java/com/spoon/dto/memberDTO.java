package com.spoon.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class memberDTO {
    private int m_no;
    private String m_id;
    private String m_pw;
    private String m_name;
    private String m_tel;
    private String m_email;
    private String m_addr;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date m_birth;

    private String m_temp; // ← ADMIN / USER 구분용
}

