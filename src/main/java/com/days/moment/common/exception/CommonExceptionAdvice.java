package com.days.moment.common.exception;

import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice//웹기반이라 필요
@Log4j2
//이 페이지는 ServletConfig에서 ComponentScan으로 이어준다.
public class CommonExceptionAdvice {//컨트롤러인데 , 예외를 처리하는 특별한 컨트롤러

    @ExceptionHandler(Exception.class)
    public String exceptAll(Exception ex, Model model){
        log.error(ex.getMessage());
        model.addAttribute("exception", ex);

        return "error_page";
    }


    @ExceptionHandler(ArithmeticException.class)
    public String exceptArithmetic(ArithmeticException ex, Model model){
        log.error(ex.getClass().getName());
        log.error(ex.getMessage());

        model.addAttribute("exception", ex);

        return "error_arithmetic_page";
    }



    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)//h404에러응답메세지
    public String Handle404(NoHandlerFoundException ex){
        return "custom404";
    }

}
