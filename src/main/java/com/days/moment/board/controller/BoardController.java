package com.days.moment.board.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.days.moment.board.dto.BoardDTO;
import com.days.moment.board.service.BoardService;
import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;



@Controller
@RequestMapping("/personalboard/*")
@Log4j2
@RequiredArgsConstructor
public class BoardController {


    private final BoardService boardService;


    @GetMapping("/register")
    public void registerGet() {

    }

    @PostMapping("/register")
    public String registerPost(BoardDTO boardDTO, RedirectAttributes redirectAttributes){

        log.info("boardDTOM       " + boardDTO);
        Long bNum = boardService.register(boardDTO);

        log.info("============c       registerPost===============");
        log.info(bNum);
        redirectAttributes.addFlashAttribute("result", bNum);

        return "redirect:/personalboard/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){
        log.info("c   getList......................" + pageRequestDTO);

        log.info("======================================");
        log.info(boardService);
        log.info(boardService.getClass().getName());
        log.info("======================================");

        PageResponseDTO<BoardDTO> responseDTO = boardService.getDTOList(pageRequestDTO);



        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page,size,total));

    }

    @GetMapping(value = {"/read","/modify"})
    public void read(Long bNum, PageRequestDTO pageRequestDTO,  Model model){
        log.info("c   read " + bNum);
        log.info("c   read " + pageRequestDTO);

        model.addAttribute("boardDTO", boardService.read(bNum));
    }
//
    @PostMapping("/remove")
    public String remove(Long bNum, RedirectAttributes redirectAttributes){
        log.info("c        remove: " + bNum);

        if(boardService.remove(bNum)){
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/personalboard/list";
    }
//
    @PostMapping("/modify")
    public String modify(BoardDTO boardDTO, PageRequestDTO pageRequestDTO, RedirectAttributes redirectAttributes){
        log.info("-------------------------------");
        log.info("-------------------------------");
        log.info(boardDTO);
        if (boardDTO.getFiles().size() > 0){
            boardDTO.getFiles().forEach(dto -> log.info(dto));
        }
        log.info("-------------------------------");
        log.info("-------------------------------");


        if(boardService.modify(boardDTO)){
            redirectAttributes.addFlashAttribute("result","modified");
        }
        redirectAttributes.addAttribute("bNum", boardDTO.getBNum());
        redirectAttributes.addAttribute("page", pageRequestDTO.getPage());
        redirectAttributes.addAttribute("size", pageRequestDTO.getSize());

        if(pageRequestDTO.getType() != null){
            redirectAttributes.addAttribute("type", pageRequestDTO.getType());
            redirectAttributes.addAttribute("keyword", pageRequestDTO.getKeyword());
        }

        return "redirect:/personalboard/read";
    }

}