package com.spoon.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spoon.dao.mainpageDAO;
import com.spoon.dao.memberDAO;
import com.spoon.dao.sellerDAO;
import com.spoon.dto.NoticeDTO;
import com.spoon.dto.itemDTO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.sellerDTO;


@Controller
public class mainpageController {

    @Autowired
    private mainpageDAO dao;
    
    @Autowired
    private sellerDAO sellerdao;
    
    @Autowired
    private memberDAO memberdao;

    @RequestMapping("/")
        public String mainpage(Principal principal, Model model) {
		    	List<itemDTO> newItems = dao.newItems();
		        model.addAttribute("newItems", newItems);
		
		        List<itemDTO> bestItems = dao.bestItems();
		        model.addAttribute("bestItems", bestItems);
		
		        List<NoticeDTO> noticeTop = dao.noticeTop();
		        model.addAttribute("noticeTop", noticeTop);
            // 1. 로그인이 된 상태인지 확인
            if (principal != null) {
                // 로그인 된 사용자 정보 가져오기
                memberDTO member = memberdao.findByMid(principal.getName());
                model.addAttribute("member", member);
                
                sellerDTO seller = sellerdao.findByMemberNo(member.getM_no());
                model.addAttribute("seller", seller);
            }
            
            // 2. 로그인을 안 했더라도 동일한 페이지(mainpage)를 보여줌
            // JSP 파일 내부에서 <sec:authorize> 등을 사용하여 버튼 노출 여부를 결정하면 됩니다.
            return "mainpage/mainpage";
        }
}
