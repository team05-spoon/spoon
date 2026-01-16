package com.spoon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spoon.dao.BoardDAO;
import com.spoon.dto.BoardDTO;
import com.spoon.dto.memberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {

    @Autowired
    private BoardDAO boardDAO;

    /* =========================
       BOARD
    ========================= */

    // 게시글 목록
    @RequestMapping("/board/boardlist")
    public String list(Model model) {
        List<BoardDTO> list = boardDAO.findAll();
        model.addAttribute("list", list);
        return "board/boardlist";
    }

    // 게시글 상세
    @RequestMapping("/board/boarddetail")
    public String detail(HttpServletRequest request, Model model) {
        String param = request.getParameter("b_no");
        if (param == null) return "redirect:/board/boardlist";

        Long b_no = Long.parseLong(param);
        BoardDTO dto = boardDAO.findByNo(b_no);

        if (dto == null) return "redirect:/board/boardlist";

        model.addAttribute("dto", dto);
        return "board/boarddetail";
    }

    @RequestMapping("/board/boardwrite")
    public String writeForm(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        memberDTO loginMember = null;
        if (session != null) {
            loginMember = (memberDTO) session.getAttribute("loginMember");
        }

        if (loginMember == null) {
            return "redirect:/member/memberloginForm";
        }

        return "board/boardwriteForm";
    }


    // 글쓰기 처리 (POST)
    @RequestMapping("/board/boardwriteForm")
    public String write(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        memberDTO loginMember = null;
        if (session != null) {
            loginMember = (memberDTO) session.getAttribute("loginMember");
        }

        if (loginMember == null) {
            return "redirect:/member/memberloginForm";
        }

        BoardDTO dto = new BoardDTO();
        dto.setB_title(request.getParameter("b_title"));
        dto.setB_memo(request.getParameter("b_memo"));
        dto.setB_write(loginMember.getM_name());
        dto.setM_no(loginMember.getM_no());

        boardDAO.insert(dto);
        return "redirect:/board/boardlist";
    }

    // 수정 폼 (GET)
    @RequestMapping("/board/boardedit")
    public String editForm(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        memberDTO loginMember =
                (session == null) ? null : (memberDTO) session.getAttribute("loginMember");

        String param = request.getParameter("b_no");
        if (param == null) return "redirect:/board/boardlist";

        Long b_no = Long.parseLong(param);
        BoardDTO dto = boardDAO.findByNo(b_no);

        // 작성자만 수정 가능
        if (dto == null || dto.getM_no() != loginMember.getM_no()) {
            return "redirect:/board/boarddetail?b_no=" + b_no;
        }

        model.addAttribute("dto", dto);
        return "board/boardedit";
    }

    // 수정 처리 (POST)
    @RequestMapping("/board/edit")
    public String edit(BoardDTO dto, HttpSession session) {

        memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/memberloginForm";

        // 권한 체크(작성자만)
        BoardDTO origin = boardDAO.findByNo(dto.getB_no());
        if (origin == null || origin.getM_no() != loginMember.getM_no()) {
            return "redirect:/board/boarddetail?b_no=" + dto.getB_no();
        }

        boardDAO.update(dto);
        return "redirect:/board/boarddetail?b_no=" + dto.getB_no();
    }

    // 삭제
    @RequestMapping("/board/boarddelete")
    public String delete(HttpServletRequest request, HttpSession session) {

        memberDTO loginMember = (memberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/memberloginForm";
        }

        String param = request.getParameter("b_no");
        if (param == null) return "redirect:/board/boardlist";

        Long b_no = Long.parseLong(param);
        BoardDTO dto = boardDAO.findByNo(b_no);

        // 작성자만 삭제 가능  (※ 여기 핵심: != 이어야 함)
        if (dto == null || dto.getM_no() != loginMember.getM_no()) {
            return "redirect:/board/boarddetail?b_no=" + b_no;
        }

        boardDAO.delete(b_no);
        return "redirect:/board/boardlist";
    }
}