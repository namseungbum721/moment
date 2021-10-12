package com.days.moment.board.dto;

import com.days.moment.board.domain.Board;
import com.days.moment.board.domain.BoardAttach;
import com.days.moment.board.domain.BoardTag;
import com.days.moment.common.dto.UploadResponseDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class BoardDTO {

    private Long bNum;
    private Long bPicCount;
    private String content;
    private String drawing;
    private LocalDateTime bRegDate;
    private LocalDateTime bModDate;
    private String memId;
    private String pName;
    private String pAddress;
    private String pLng;
    private String pLat;







    @Builder.Default
    private List<UploadResponseDTO> files = new ArrayList<>();
    @Builder.Default
    private List<TagResponseDTO> tags = new ArrayList<>();

    public Board getDomain() {

        Board board = Board.builder()
                .bNum(bNum)
                .content(content)
                .drawing(drawing)
                .bRegDate(bRegDate)
                .bModDate(bModDate)
                .pName(pName)
                .pAddress(pAddress)
                .pLat(pLat)
                .pLng(pLng)
                .memId(memId)
                .bPicCount(bPicCount)
                .build();

        tags.forEach(tagResponseDTO -> {
            BoardTag tag = BoardTag.builder()
                    .bNum(tagResponseDTO.getBNum())
                    .tag(tagResponseDTO.getTag())
                    .build();
            board.addTag(tag);
        });

        files.forEach(uploadResponseDTO -> {
            BoardAttach attach = BoardAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            board.addAttach(attach);
        });


        return board;
    }
}