package com.days.moment.board.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TagResponseDTO {
    private String tag;
    private Long bNum;

    public String getTag() {
        return tag;
    }

}
