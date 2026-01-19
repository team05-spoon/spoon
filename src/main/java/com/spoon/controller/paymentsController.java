package com.spoon.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.spoon.dao.cartDAO;
import com.spoon.dao.memberDAO;
import com.spoon.dao.ordersDAO;
import com.spoon.dto.cartDTO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.ordersDTO;

@Controller
public class paymentsController {

    @Autowired private cartDAO cartDao;
    @Autowired private ordersDAO ordersDao;
    @Autowired private memberDAO memberDao;

    @GetMapping("/payments/payments")
    public String paymentPage(Principal principal, Model model) {
        if (principal == null) return "redirect:/member/login";
        memberDTO member = memberDao.findByMid(principal.getName());
        model.addAttribute("member", member);
        List<cartDTO> cartList = cartDao.listDao(member.getM_no());
        if (cartList == null || cartList.isEmpty()) 
        	
        	return "redirect:/cart/cartlist";

        int totalAmount = 0;
        for (cartDTO cart : cartList) {
            totalAmount += (cart.getC_price() * cart.getC_count());
        }
        String orderName = "Spoon 주문 상품"; 
        if (cartList.size() > 1) orderName += " 외 " + (cartList.size() - 1) + "건";

        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("orderName", orderName);
        return "payments/payments";
    }

    @Transactional
    @PostMapping("/payments/complete")
    @ResponseBody
    public String completePayment(@RequestBody Map<String, Object> data, Principal principal) {
        if (principal == null) return "error:auth";
        
        try {
            // 1. 회원 정보 및 장바구니 목록 가져오기
            memberDTO member = memberDao.findByMid(principal.getName());
            List<cartDTO> cartList = cartDao.listDao(member.getM_no());
            
            // 2. 장바구니에 담긴 각 상품별로 주문 생성
            for (cartDTO cart : cartList) {
                ordersDTO order = new ordersDTO();
                
                // 가격 계산
                long totalPrice = (long) cart.getC_price() * cart.getC_count();
                order.setO_tp(totalPrice);
                
                // [수정 핵심] 사용자가 입력한 데이터(data)가 있으면 그것을 사용하고, 없으면 회원 기본정보 사용
                
                // 주문자 정보 세팅
                order.setO_name(data.get("o_name") != null ? (String)data.get("o_name") : member.getM_name());
                order.setO_tel(data.get("o_tel") != null ? (String)data.get("o_tel") : member.getM_tel());
                order.setO_addr(data.get("o_addr") != null ? (String)data.get("o_addr") : member.getM_addr());

                // 배송지 정보 세팅 (주문서에서 수정한 주소가 반영되는 부분)
                order.setD_name(data.get("d_name") != null ? (String)data.get("d_name") : member.getM_name());
                order.setD_tel(data.get("d_tel") != null ? (String)data.get("d_tel") : member.getM_tel());
                order.setD_addr(data.get("d_addr") != null ? (String)data.get("d_addr") : member.getM_addr());

                // 기타 정보 세팅
                order.setM_no(member.getM_no());
                order.setI_no(cart.getI_no());
                order.setC_count(cart.getC_count());
                order.setC_price((long)cart.getC_price());
                
                // DB 저장
                ordersDao.writeDao(order); 
            }
            
            // 3. 결제 완료 후 장바구니 비우기
            cartDao.cleancart(member.getM_no());
            
            return "success";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @GetMapping("/payments/success")
    public String paymentSuccess() {
        // prefix: /WEB-INF/views/, suffix: .jsp 설정 기준
        return "payments/success"; 
    }
    @RequestMapping("/payments/fail")
    public String paymentFailure() {
    	return "payments/fail";
    }
}