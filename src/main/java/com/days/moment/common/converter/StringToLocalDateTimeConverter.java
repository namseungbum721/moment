package com.days.moment.common.converter;

import lombok.extern.log4j.Log4j2;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
@Log4j2
public class StringToLocalDateTimeConverter implements Converter<String, LocalDateTime> {

    @Override
    public LocalDateTime convert(String source) {

        log.info("----------");
        log.info("convert:" + source);

        Pattern pattern =  Pattern.compile("^((19|20)\\d\\d)?([- /.])?(0[1-9]|1[012])([- /.])?(0[1-9]|[12][0-9]|3[01])$");
        Matcher matcher = pattern.matcher(source);

        if(matcher.find()) {
            return LocalDateTime.parse(
                    source + "T00:00:00", DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        }

        return LocalDateTime.now();
    }
}