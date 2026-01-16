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
            memberDTO member = memberDao.findByMid(principal.getName());
            List<cartDTO> cartList = cartDao.listDao(member.getM_no());
            
            for (cartDTO cart : cartList) {
                ordersDTO order = new ordersDTO();
                
                // (long) 캐스팅을 통해 타입을 확실히 맞춥니다.
                long totalPrice = (long) cart.getC_price() * cart.getC_count();
                
                order.setO_tp(totalPrice);          // 이제 에러 안 납니다!
                order.setO_name(member.getM_name());
                order.setO_addr(member.getM_addr());
                order.setO_tel(member.getM_tel());
                order.setD_name(member.getM_name());
                order.setD_addr(member.getM_addr());
                order.setD_tel(member.getM_tel());
                order.setM_no(member.getM_no());
                order.setI_no(cart.getI_no());
                order.setC_count(cart.getC_count());
                order.setC_price((long)cart.getC_price());
                
                ordersDao.writeDao(order); 
            }
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
}