package com.days.moment.board.mapper;

import com.days.moment.board.domain.Board;
import com.days.moment.board.domain.BoardAttach;
import com.days.moment.board.domain.BoardTag;
import com.days.moment.common.dto.PageRequestDTO;


import java.util.List;


public interface BoardMapper {

    void insert(Board board);

    List<Board> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    int updateCount(Long bNum);

    int updateTag(Long bNum);

    Board select(Long bNum);

    int delete(Long bNum);

    int update(Board board);

    int insertAttach(BoardAttach attach);

    int deleteAttach(Long bNum);

    int insertTag(BoardTag tag);

    int deleteTag(Long bNum);






}