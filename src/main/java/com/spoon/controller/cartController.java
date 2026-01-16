package com.spoon.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spoon.dao.cartDAO;
import com.spoon.dao.itemDAO;
import com.spoon.dao.memberDAO;
import com.spoon.dto.cartDTO;
import com.spoon.dto.memberDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class cartController {

	@Autowired
	cartDAO dao;
	
	@Autowired
	itemDAO itemdao;
	
	@Autowired
	memberDAO memberdao;
	
	@RequestMapping("/cart/cartlist")
    public String cartList(Model model, Principal principal) {
		String m_id = principal.getName();
	    memberDTO member = memberdao.findByMid(m_id);
	    int m_no = member.getM_no();

	    // 수정된 listDao 호출
	    model.addAttribute("list", dao.listDao(m_no));

	    int totalPrice = 0;
	    List<cartDTO> list = dao.listDao(m_no); // DB에서 장바구니 목록을 받아옴
	    if (list != null) {
	        for (cartDTO cart : list) {
	            totalPrice += cart.getC_price() * cart.getC_count();
	        }
	    }
	    model.addAttribute("totalPrice", totalPrice);

	    return "cart/cartlist";
	}
	@RequestMapping("/cart/cartdelete")
	public String cartdelete(HttpServletRequest request) {
		int c_no = Integer.parseInt(request.getParameter("c_no"));
		dao.deleteDao(c_no);
		return "redirect:/cart/cartlist";
	}
	@RequestMapping("/cart/cartupdateForm")
	public String cartupdateForm(HttpServletRequest request, Model model) {
		int c_no = Integer.parseInt(request.getParameter("m_no"));
		model.addAttribute("update",dao.viewDao(c_no));
		return "cart/cartupdateForm";
	}

	// 장바구니 추가
	@RequestMapping("/cart/cartadd")
	public String cartadd(
	        @RequestParam("i_no") int i_no,
	        @RequestParam("c_name") String c_name,
	        @RequestParam("c_price") long c_price,
	        @RequestParam("c_count") int c_count,
	        Principal principal) {

	    String m_id = principal.getName();
	    memberDTO loginUser = memberdao.findByMid(m_id);

	    cartDTO dto = new cartDTO();
	    dto.setI_no(i_no);
	    dto.setC_name(c_name);
	    dto.setC_price(c_price);
	    dto.setC_count(c_count);
	    dto.setM_no(loginUser.getM_no()); // 로그인한 사용자 번호 세팅

	    dao.writeDao(dto); // 장바구니에 물품 추가하는 로직

	    return "redirect:/cart/cartlist";
	}

    // 장바구니 수량 수정
    @RequestMapping("/cart/cartupdate")
    public String cartUpdate(cartDTO dto, Principal principal) {

        String m_id = principal.getName();
        memberDTO member = memberdao.findByMid(m_id);

        // ✅ where절 조건(c_no AND m_no) 때문에 m_no 세팅
        dto.setM_no(member.getM_no());

        dao.updateDao(dto);
        return "redirect:/cart/cartlist";
    }
}



