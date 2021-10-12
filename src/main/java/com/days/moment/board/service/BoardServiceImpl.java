package com.days.moment.board.service;

import com.days.moment.board.domain.Board;
import com.days.moment.board.dto.BoardDTO;
import com.days.moment.board.mapper.BoardMapper;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;


@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

    private final BoardMapper boardMapper;

    @Override
    public Long register(BoardDTO boardDTO) {

        Board board = boardDTO.getDomain();

        boardMapper.insert(board);

        Long bNum = board.getBNum();



        board.getAttachList().forEach(attach -> {
            attach.setBNum(bNum);
            boardMapper.insertAttach(attach);
        });

        board.getTagList().forEach(tag -> {
            tag.setBNum(bNum);
            boardMapper.insertTag(tag);
        });

        boardMapper.updateCount(bNum);

        return board.getBNum();
    }

    @Override
    public PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<BoardDTO> dtoList = boardMapper.getList(pageRequestDTO).stream().map(board -> board.getDTO()).collect(Collectors.toList());
        int count = boardMapper.getCount(pageRequestDTO);

        PageResponseDTO<BoardDTO> pageResponseDTO = PageResponseDTO.<BoardDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;

    }

    @Override
    public BoardDTO read(Long bNum) {
        Board board =  boardMapper.select(bNum);

        if(board != null){
            return board.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long bNum) {
        return boardMapper.delete(bNum) > 0;
    }

    @Override
    public boolean modify(BoardDTO boardDTO) {

        boardMapper.deleteAttach(boardDTO.getBNum()); //기존에 있던 첨부파일 삭제
        boardMapper.deleteTag(boardDTO.getBNum());

        Board board = boardDTO.getDomain();

        Long bNum = board.getBNum();

        board.getTagList().forEach(tag -> {
            tag.setBNum(bNum);
            boardMapper.insertTag(tag);
        });

        board.getAttachList().forEach(attach -> {
            attach.setBNum(bNum);
            boardMapper.insertAttach(attach);
        });

        boardMapper.updateCount(bNum);
        boardMapper.updateTag(bNum);

        return boardMapper.update(board) > 0; //업데이트 해주고 기존의 있던 첨부파일 지우고 새로운 첨부파일 추가해줘야함
    }

}