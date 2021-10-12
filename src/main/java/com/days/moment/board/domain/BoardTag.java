package com.days.moment.board.domain;


import lombok.*;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BoardTag {

    private Long bNum;
    private String tag;

    public void setBNum(Long bNum) {
        this.bNum = bNum;
    }

}
