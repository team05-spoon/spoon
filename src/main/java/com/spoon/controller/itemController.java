package com.spoon.controller;
import java.io.File;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spoon.dao.itemDAO;
import com.spoon.dao.memberDAO;
import com.spoon.dao.sellerDAO;
import com.spoon.dto.itemDTO;
import com.spoon.dto.memberDTO;
import com.spoon.dto.sellerDTO;

import jakarta.servlet.http.HttpServletRequest; 

@Controller
public class itemController { 
	
	@Autowired 
	itemDAO dao;
	@Autowired
	memberDAO memberdao;
	
	@Autowired
	sellerDAO sellerdao;
	
	
	@RequestMapping("/item/itemwriteForm") 
	public String itemwriteForm(Principal principal, Model model) {
		memberDTO member = memberdao.findByMid(principal.getName());

	    sellerDTO seller = sellerdao.findByMemberNo(member.getM_no());

	    model.addAttribute("seller", seller);
		return "item/itemwriteForm"; } 
	
	@RequestMapping("/item/itemwrite") 
	public String write( @RequestParam("i_tfile") MultipartFile i_tfile,
						@RequestParam("i_dfile") MultipartFile i_dfile, itemDTO dto) throws Exception {
		if(!i_tfile.isEmpty()) {
			String i_timage = i_tfile.getOriginalFilename();
			i_tfile.transferTo(new File("C:\\Springboot\\spoon\\src\\main\\resources\\static\\timages\\"+i_timage));
			dto.setI_timage(i_timage); } 
		
		if(!i_dfile.isEmpty()){
			String i_dimage = i_dfile.getOriginalFilename();
			i_dfile.transferTo(new File("C:\\Springboot\\spoon\\src\\main\\resources\\static\\dimages\\"+i_dimage));
			dto.setI_dimage(i_dimage); } 
		
		dao.writeDao(dto);
			
		return "redirect:/item/myitemlist";
		}
	@RequestMapping("/item/itemlist")
	public String itemlist(@RequestParam(value="i_ctg", required=false) String i_ctg, Model model) {
	    // 파라미터로 받은 i_ctg를 listDao에 전달합니다.
	    model.addAttribute("list", dao.listDao(i_ctg));
	    return "item/itemlist";
	}
	@RequestMapping("/item/adminitemlist")
	public String adminitemlist(@RequestParam(value="i_ctg", required=false) String i_ctg, Model model) {
	    // 파라미터로 받은 i_ctg를 listDao에 전달합니다.
	    model.addAttribute("list", dao.listDao(i_ctg));
	    return "item/adminitemlist";
	}
	
	@RequestMapping("/item/myitemlist")
	public String myitemlist(Principal principal, Model model) {
		memberDTO member = memberdao.findByMid(principal.getName());
		sellerDTO seller = sellerdao.findByMemberNo(member.getM_no());

		if (seller != null) {
	        model.addAttribute("seller", seller);
	        
	        model.addAttribute("list", dao.itemMyListDao(seller.getS_no())); 
	    }
	    
	    return "item/myitemlist";
	}
	
	@RequestMapping("/item/itemmemberview")
    public String itemmemberview(HttpServletRequest request, Model model) {
        int i_no = Integer.parseInt(request.getParameter("i_no"));
        model.addAttribute("view", dao.viewDao(i_no));
        return "item/itemmemberview";
    }
	
	
	@RequestMapping("/item/itemsellerview")
	public String itemview(HttpServletRequest request,Model model) {
		int i_no = Integer.parseInt(request.getParameter("i_no"));
		model.addAttribute("view",dao.viewDao(i_no));
		return "item/itemsellerview";
	}
			@RequestMapping("/item/delete") 
			public String delete(HttpServletRequest request) { 
				int i_no = Integer.parseInt(request.getParameter("i_no")); 
				dao.deleteDao(i_no); 
				return "redirect:/item/myitemlist";
				} 
			
			@RequestMapping("/item/itemupdateForm") 
			public String itemupdateForm(HttpServletRequest request, Model model){
				int i_no = Integer.parseInt(request.getParameter("i_no"));
				model.addAttribute("update", dao.viewDao(i_no));
				return "item/itemupdateForm"; 
				} 
			
			@RequestMapping("/item/itemupdate") 
			public String update(@RequestParam("i_tfile") MultipartFile i_tfile,
					@RequestParam("i_dfile") MultipartFile i_dfile, itemDTO dto) throws Exception
			{
				if(!i_tfile.isEmpty()) { String i_timage = i_tfile.getOriginalFilename();
				i_tfile.transferTo(new File("C:\\Springboot\\spoon\\src\\main\\resources\\static\\timages\\"+i_timage));
				dto.setI_timage(i_timage); }
				
				if(!i_dfile.isEmpty()) { String i_dimage = i_dfile.getOriginalFilename();
				i_dfile.transferTo(new File("C:\\Springboot\\spoon\\src\\main\\resources\\static\\dimages\\"+i_dimage)); 
				dto.setI_dimage(i_dimage); } 
				
				dao.updateDao(dto);
				
				return "redirect:/item/myitemlist";
				} 
			
}
