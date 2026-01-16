package com.spoon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spoon.dao.memberDAO;
import com.spoon.dao.sellerDAO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.sellerDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class memberController {	
    @Autowired
    memberDAO dao;
    
    @Autowired
    sellerDAO sellerdao;
    
	@Autowired
	private PasswordEncoder passwordEncoder;
    
    @RequestMapping("/member/memberloginForm")
    public String memberloginForm() {
    	return "member/memberloginForm";
    }
    @RequestMapping("/member/memberwriteForm")
    public String memberwriteForm() {
    	return "member/memberwriteForm";
    }
    @RequestMapping("/member/memberwrite")
    public String memberwrite(memberDTO dto) {
    	String encodedPassword = passwordEncoder.encode(dto.getM_pw());
    	dto.setM_pw(encodedPassword);
    	dao.writeDao(dto);
    	return "redirect:/member/memberloginForm";
    }
    @RequestMapping("/member/memberlist")
    public String memberlist(Model model) {
    	model.addAttribute("list", dao.listDao());
    	return "member/memberlist";
    }
    @RequestMapping("/member/memberview")
    public String sellerview(HttpServletRequest request, Model model) {
    	int m_no = Integer.parseInt(request.getParameter("m_no"));
        // 1. 회원 정보 조회
        memberDTO member = dao.viewDao(m_no);
        model.addAttribute("view", member);
        
        // 2. 판매자 정보 조회
        sellerDTO seller = sellerdao.getSellerByMemberNo(m_no); // 판매자 없으면 null
        model.addAttribute("seller", seller);
        
        return "member/memberview";
    }
    @RequestMapping("/member/memberview2")
    public String sellerview2(HttpServletRequest request, Model model) {
    	int m_no = Integer.parseInt(request.getParameter("m_no"));
    	model.addAttribute("view",dao.viewDao(m_no));
    	return "member/memberview2";
    }
    @RequestMapping("/member/memberdelete")
    public String memberdelete(HttpServletRequest request) {
    	int m_no = Integer.parseInt(request.getParameter("m_no"));
    	dao.deleteDao(m_no);
    	return "redirect:/member/memberlist";
    }
    @RequestMapping("/member/memberupdateForm")
    public String memberupdateForm(HttpServletRequest request, Model model) {
    	int m_no = Integer.parseInt(request.getParameter("m_no"));
    	model.addAttribute("update", dao.viewDao(m_no));
    	return "member/memberupdateForm";
    }
    
    @RequestMapping("/member/memberupdate")
    public String memberupdate(memberDTO dto) {
    	memberDTO existingMember = dao.viewDao(dto.getM_no());

       
        if (dto.getM_pw() != null && !dto.getM_pw().trim().isEmpty()) {
            
            String encodedPassword = passwordEncoder.encode(dto.getM_pw());
            dto.setM_pw(encodedPassword);
        } else {
            
            dto.setM_pw(existingMember.getM_pw());
        }
    	dao.updateDao(dto);
    	return "redirect:/";
    }
    @RequestMapping("/member/memberdelete2")
    public String memberdelete2(HttpServletRequest request) {
    	int m_no = Integer.parseInt(request.getParameter("m_no"));
    	dao.deleteDao(m_no);
    	request.getSession().invalidate();
    	return "redirect:/";
    }
    
    
}