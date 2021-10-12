package com.days.moment.board.service;


import com.days.moment.board.dto.BoardDTO;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface BoardService {

    Long register(BoardDTO boardDTO);

    PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO);

    BoardDTO read(Long bNum);

    boolean remove(Long bNum);

    boolean modify(BoardDTO boardDTO);

}