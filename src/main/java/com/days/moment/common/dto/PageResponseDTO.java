package com.days.moment.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageResponseDTO<E> {
    //나중에 타입결정을위해 제네릭으로 선언(여러곳에서 쓰일 수 있게)
    private List<E> dtoList;
    private int count;



}
