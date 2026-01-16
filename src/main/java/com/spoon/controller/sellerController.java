package com.spoon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spoon.dao.memberDAO;
import com.spoon.dao.sellerDAO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.sellerDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class sellerController {
	
	 @Autowired
	    sellerDAO dao;
	 
	 @Autowired
	 memberDAO memberdao;
	      	    
	    @RequestMapping("/seller/sellerwriteForm")
	    public String sellerwriteForm(Principal principal, Model model) {
	    	memberDTO member = memberdao.findByMid(principal.getName());
	    	model.addAttribute("member", member);
	    	return "seller/sellerwriteForm";
	    }
	    @RequestMapping("/seller/sellerwrite")
	    public String sellerwrite(sellerDTO dto) {
	    	dao.writeDao(dto);
	    	return "redirect:/";
	    }
	    
	    @RequestMapping("/seller/sellerlist")
	    public String sellerlist(Model model) {
	    	model.addAttribute("list",dao.listDao());
	    	return "seller/sellerlist";
	    }
	    @RequestMapping("/seller/sellerlist2")
	    public String sellerlist2(Model model) {
	    	model.addAttribute("list",dao.listDao());
	    	return "seller/sellerlist2";
	    }
	    @RequestMapping("/seller/sellerview")
	    public String sellerview(HttpServletRequest request, Model model) {
	    	int s_no = Integer.parseInt(request.getParameter("s_no"));
	    	model.addAttribute("view", dao.viewDao(s_no));
	    	return "seller/sellerview";
	    }
	 
	    @RequestMapping("/seller/sellerdelete")
	    public String sellerdelete(HttpServletRequest request) {
	    	int s_no = Integer.parseInt(request.getParameter("s_no"));
	    	dao.deleteDao(s_no);
	    	return "redirect:/seller/sellerlist";
	    }
	    @RequestMapping("/seller/sellerupdateForm")
	    public String sellerupdateForm(HttpServletRequest request, Model model) {
	    	int s_no = Integer.parseInt(request.getParameter("s_no"));
	    	model.addAttribute("update",dao.viewDao(s_no));
	    	return "seller/sellerupdateForm";
	    }
	    @RequestMapping("/seller/sellerupdateForm2")
	    public String sellerupdateForm2(HttpServletRequest request, Model model) {
	    	int s_no = Integer.parseInt(request.getParameter("s_no"));
	    	model.addAttribute("update",dao.viewDao(s_no));
	    	return "seller/sellerupdateForm2";
	    }
	    
	    @RequestMapping("/seller/sellerupdate")
	    public String sellerupdate(sellerDTO dto) {
	    	dao.updateDao(dto);
	    	return "redirect:/seller/sellerlist2";
	    }

}
	
