package com.days.moment.board.mapper;

import com.days.moment.board.config.BoardRootConfig;
import com.days.moment.board.domain.Board;
import com.days.moment.board.dto.BoardDTO;
import com.days.moment.common.config.RootConfig;
import com.days.moment.common.dto.PageRequestDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.stream.IntStream;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {BoardRootConfig.class, RootConfig.class} )
public class BoardMapperTests {

    @Autowired
    BoardMapper boardMapper;

    @Test
    public void testDummies() {
        IntStream.rangeClosed(1, 50).forEach(i -> {
            Board board = Board.builder()
                    .content("content" + i)
                    .drawing("drawing" +i)
                    .build();
            boardMapper.insert(board);
        });


    }

    @Test
    public void testList(){

        PageRequestDTO pageRequestDTO =
                PageRequestDTO.builder()
                        .type("TC")
                        .keyword("AA")
                        .build();

        log.info(pageRequestDTO);

        boardMapper.getList(pageRequestDTO).forEach(board -> log.info(board));
    }

    @Test
    public void testSelect(){

        Board board = boardMapper.select(300L);

        log.info(board);
        log.info("--------------------------");
        board.getAttachList().forEach(attach -> log.info(attach));
    }

}
