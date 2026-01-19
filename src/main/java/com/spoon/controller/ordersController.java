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
    public String orderwrite(ordersDTO dto, Principal principal, RedirectAttributes rttr) {
        if (principal == null) return "redirect:/member/memberlogin";
        
        // 사용자가 입력한 d_name, d_addr 등이 담긴 dto를 'orderData'라는 이름으로 결제창에 보냅니다.
        rttr.addFlashAttribute("orderData", dto);
        rttr.addFlashAttribute("amount", dto.getC_price() * dto.getC_count());
        
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
    @RequestMapping("/payments/completePayment")
    public String completePayment(@RequestBody Map<String, Object> data, Principal principal) {
        try {
            if (principal == null) return "error:auth";
            String m_id = principal.getName();
            memberDTO member = memberdao.findByMid(m_id);

            // AJAX로 넘어온 데이터들로 DTO 생성
            ordersDTO order = new ordersDTO();
            order.setM_no(member.getM_no());
            order.setO_name((String)data.get("o_name"));
            order.setO_tel((String)data.get("o_tel"));
            order.setO_addr((String)data.get("o_addr"));
            order.setD_name((String)data.get("d_name"));
            order.setD_tel((String)data.get("d_tel"));
            order.setD_addr((String)data.get("d_addr"));
            order.setI_no(Integer.parseInt(data.get("i_no").toString()));
            order.setC_count(Integer.parseInt(data.get("c_count").toString()));
            order.setC_price(Long.parseLong(data.get("c_price").toString()));

            // [중요] 실제로 DB에 저장하는 DAO 메서드 호출
            // (메서드 명은 본인의 DAO에 맞게 수정하세요: 예: insertOrder)
            dao.writeDao(order); 
            
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