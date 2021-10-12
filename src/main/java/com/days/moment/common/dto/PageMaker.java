package com.days.moment.common.dto;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageMaker {

    private int start, end, page, size, total;
    private boolean prev, next;

    public PageMaker(int page, int size, int total){

        this.page = page;
        this.size = size;
        this.total = total;


        end = (int)(Math.ceil(page / 10.0) * 10);
        start = end - 9;

        prev = start > 1;
        next = (total / (double)size) > end;

        //아래 if문을 삼항연산자로 변경
        end = end * size > total ? (int)(Math.ceil(total/(double)size)) : end;

//        if(end * size > total){
//            end = (int)(Math.ceil(total/(double)size));
//        }



    }



}
