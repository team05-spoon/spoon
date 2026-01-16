package com.spoon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spoon.dao.NoticeDAO;
import com.spoon.dto.NoticeDTO;
import com.spoon.dto.memberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {

    @Autowired
    private NoticeDAO noticeDAO;

    /* =========================
       NOTICE
    ========================= */

    //목록
    @RequestMapping("/notice/noticelist")
    public String list(Model model) {
        List<NoticeDTO> list = noticeDAO.findAll();
        model.addAttribute("list", list);
        return "notice/noticelist";
    }

    //상세
    @RequestMapping("/notice/noticedetail")
    public String detail(HttpServletRequest request, Model model) {
        Long n_no = Long.parseLong(request.getParameter("n_no"));
        model.addAttribute("dto", noticeDAO.findByNo(n_no));
        return "notice/noticedetail";
    }

    // 작성폼
    @RequestMapping("/notice/noticewriteForm")
    public String writeForm(HttpSession session) {

        memberDTO mdto = (memberDTO) session.getAttribute("loginMember");
        if (mdto == null) {
            return "redirect:/member/memberloginForm";
        }

        //관리자만 허용 m_temp=ADMIN
        if (!"ADMIN".equals(mdto.getM_temp())) {
            return "redirect:/mainpage/mainpage2"; // 또는 공지 목록으로 보내도 됨
        }

        return "notice/noticewriteForm";
    }

    //작성 처리
    @RequestMapping("/notice/noticewrite")
    public String write(NoticeDTO dto, HttpSession session) {

        memberDTO mdto = (memberDTO) session.getAttribute("loginMember");

        if (mdto == null) {
            return "redirect:/member/memberloginForm";
        }

        if (!"ADMIN".equals(mdto.getM_temp())) {
            return "redirect:/notice/noticelist";
        }
        
        noticeDAO.insert(dto);
        
        return "redirect:/notice/noticelist";
    }
    //수정
    @GetMapping("/notice/noticeedit")
    public String editForm(@RequestParam("n_no") Long n_no, Model model, HttpSession session) {

        memberDTO mdto = (memberDTO) session.getAttribute("loginMember");
        if (mdto == null) return "redirect:/member/memberloginForm";
        if (!"ADMIN".equals(mdto.getM_temp())) return "redirect:/notice/noticelist";

        NoticeDTO dto = noticeDAO.findByNo(n_no);   // DB 조회
        model.addAttribute("dto", dto);             // JSP에 dto 전달

        return "notice/noticeedit"; // JSP 파일명과 맞추기
    }

    // 수정 처리
    @RequestMapping("/notice/noticeedit")
    public String noticeEdit(NoticeDTO dto, HttpSession session) {

        memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
        if (loginMember == null || !"ADMIN".equals(loginMember.getM_temp())) {
            return "redirect:/member/memberloginForm";
        }

        noticeDAO.update(dto);
        return "redirect:/notice/noticedetail?n_no=" + dto.getN_no();
    }
    // 삭제
    @RequestMapping("/notice/noticedelete")
    public String delete(HttpServletRequest request,HttpSession session) {

    	 memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
         if (loginMember == null) {
             return "redirect:/member/memberloginForm";
         }
         String param = request.getParameter("n_no");
         if (param == null) return "redirect:/notice/noticelist";
         
         
         Long n_no = Long.parseLong(param);
         NoticeDTO dto = noticeDAO.findByNo(n_no);
         
         if ("ADMIN".equals(loginMember.getM_temp())) {
             noticeDAO.delete(n_no);
             return "redirect:/notice/noticelist";
         }
         
         noticeDAO.delete(n_no);
         return "redirect:/notice/noticelist";
    }
}
