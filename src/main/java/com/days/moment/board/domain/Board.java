package com.days.moment.board.domain;

import com.days.moment.board.dto.BoardDTO;
import com.days.moment.board.dto.TagResponseDTO;
import com.days.moment.common.dto.UploadResponseDTO;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
@ToString
public class Board {

    private String drawing, content ,pName, pAddress, pLng, pLat;
    private Long bNum, bPicCount;
    private LocalDateTime bRegDate, bModDate;
    private String memId;





    @Builder.Default
    private List<BoardAttach> attachList = new ArrayList<>();
    @Builder.Default
    private List<BoardTag> tagList = new ArrayList<>();

    public BoardDTO getDTO() {
        BoardDTO boardDTO = BoardDTO.builder()
                .bNum(bNum)
                .drawing(drawing)
                .content(content)
                .bRegDate(bRegDate)
                .bModDate(bModDate)
                .pName(pName)
                .pAddress(pAddress)
                .pLat(pLat)
                .pLng(pLng)
                .memId(memId)
                .bPicCount(bPicCount)
                .build();

        List<TagResponseDTO> tagResponseDTOList = tagList.stream().map(tag -> {
            TagResponseDTO tagResponseDTO = TagResponseDTO.builder()
                    .tag(tag.getTag())
                    .build();
            return tagResponseDTO;
        }).collect(Collectors.toList());

        boardDTO.setTags(tagResponseDTOList);

        List<UploadResponseDTO> uploadResponseDTOList = attachList.stream().map(attach -> {
            UploadResponseDTO uploadResponseDTO = UploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());

        boardDTO.setFiles(uploadResponseDTOList);

        return boardDTO;
    }



    public void setBNum(Long bNum) {this.bNum = bNum;}

    public void addAttach(BoardAttach attach) {

        attachList.add(attach);
    }

    public void addTag(BoardTag tag) {

        tagList.add(tag);
    }
}