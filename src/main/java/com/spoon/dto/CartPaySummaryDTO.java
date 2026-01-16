package com.spoon.dto;

import lombok.Data;

@Data
public class CartPaySummaryDTO {
    private int totalAmount;   // 총 결제금액
    private int itemCount;     // 총 수량
    private String firstName;  // 대표 상품명
}