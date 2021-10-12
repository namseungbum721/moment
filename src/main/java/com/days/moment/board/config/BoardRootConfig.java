package com.days.moment.board.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.days.moment.board.mapper")
@ComponentScan(basePackages = "com.days.moment.board.service")
@Import(BoardAOPConfig.class)
public class BoardRootConfig {
}
