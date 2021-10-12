package com.days.moment.board.domain;


import lombok.*;

import java.time.LocalDateTime;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class BoardAttach {

    private Long bNum;
    private String uuid;
    private String path;
    private String fileName;
    private boolean image;
    private LocalDateTime uploadDate;
    private String selectLocation;



    public void setBNum(Long bNum) {
        this.bNum = bNum;
    }
}