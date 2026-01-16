package com.spoon.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spoon.dao.cartDAO;
import com.spoon.dao.itemDAO;
import com.spoon.dao.memberDAO;
import com.spoon.dao.ordersDAO;
import com.spoon.dto.cartDTO;
import com.spoon.dto.itemDTO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.ordersDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ordersController {

    @Autowired
    cartDAO cartdao;

    @Autowired
    ordersDAO dao;

    @Autowired
    memberDAO memberdao;
    
    @Autowired
    itemDAO itemdao;

    // 주문 작성 폼
    @RequestMapping("/order/orderwriteForm")
    public String orderwriteForm(Principal principal, Model model) {
        String m_id = principal.getName();
        memberDTO member = memberdao.findByMid(m_id);
        int m_no = member.getM_no();
        
        model.addAttribute("member", member);

        // 장바구니 목록 가져오기
        List<cartDTO> cartList = cartdao.listDao(m_no);
        model.addAttribute("cartList", cartList);

        // 총 가격 계산
        long totalPrice = 0;
        for (cartDTO cart : cartList) {
            totalPrice += cart.getC_price() * cart.getC_count();
        }
        model.addAttribute("totalPrice", totalPrice);

        return "order/orderwriteForm"; 
    }

    @RequestMapping("/order/orderwrite")
    public String orderComplete(ordersDTO dto, Principal principal,RedirectAttributes rttr) {
    	 if (principal == null) return "redirect:/member/memberlogin";
    	String m_id = principal.getName();
        memberDTO member = memberdao.findByMid(m_id);
        int m_no = member.getM_no();
        
        dto.setM_no(m_no);
        
    	dao.writeDao(dto);
    	
    	
    	rttr.addFlashAttribute("amount", dto.getC_price() * dto.getC_count());
        rttr.addFlashAttribute("orderName", "Spoon 주문 결제");
        rttr.addFlashAttribute("merchantUid", "spoon_" + System.currentTimeMillis());
        
        return "redirect:/payments/payments";
    }

 // 3. 실제 결제창 화면 (여기서 '미로그인' 해결)
    @RequestMapping("/payments/payments")
    public String paymentPage(Principal principal, Model model) {
        if (principal == null) return "redirect:/member/memberlogin";
        
        memberDTO member = memberdao.findByMid(principal.getName());
        model.addAttribute("member", member); // ${member.m_name} 등으로 사용 가능
        
        return "payments/payments"; 
    }
 // 4. 결제 완료 처리 (AJAX)
    @ResponseBody
    public String completePayment(@RequestBody Map<String, Object> data, Principal principal) {
        try {
            if (principal == null) return "error:auth";
            memberDTO member = memberdao.findByMid(principal.getName());
            
            // 장바구니 비우기
            cartdao.cleancart(member.getM_no());
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error:server";
        }
    }
@RequestMapping("/order/orderlist")
public String orderList(Model model, Principal principal) {
	String m_id = principal.getName();
    memberDTO member = memberdao.findByMid(m_id);
    int m_no = member.getM_no();

    // 수정된 listDao 호출
    model.addAttribute("list", dao.listDao(m_no));

    int totalPrice = 0;
    List<cartDTO> list = cartdao.listDao(m_no); // DB에서 장바구니 목록을 받아옴
    if (list != null) {
        for (cartDTO cart : list) {
            totalPrice += cart.getC_price() * cart.getC_count();
        }
    }
    model.addAttribute("totalPrice", totalPrice);

    return "order/orderlist";
}
@RequestMapping("/order/orderview")
public String orderView(HttpServletRequest request, Principal principal, Model model) {
    long o_no = Long.parseLong(request.getParameter("o_no"));
    String m_id = principal.getName();
    memberDTO member = memberdao.findByMid(m_id);
    int m_no = member.getM_no();

    // 2. 주문 번호(o_no)로 해당 주문 정보 한 건 가져오기
    // (ordersDAO에 findByOno 메서드가 있다고 가정)
    ordersDTO order = dao.viewDao(o_no);
    model.addAttribute("order", order);

    // 3. 상품명을 보여주기 위해 장바구니(cart) 목록 가져오기
    int i_no = order.getI_no(); 
    itemDTO item = itemdao.viewDao(i_no); 
    model.addAttribute("item", item);

    // 4. 총 가격 계산
    int totalPrice = (int)order.getC_price() * order.getC_count();
    model.addAttribute("totalPrice", totalPrice);

    return "order/orderview"; // 상세보기 전용 JSP로 이동
}
}