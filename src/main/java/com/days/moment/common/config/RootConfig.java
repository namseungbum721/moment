package com.days.moment.common.config;

import com.days.moment.board.config.BoardRootConfig;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Log4j2
@Configuration
@Import(BoardRootConfig.class)
@EnableTransactionManagement
public class RootConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource());
        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public DataSource dataSource(){
        HikariConfig config = new HikariConfig();
        //config.setDriverClassName("com.mysql.cj.jdbc.Driver");


        config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

        //config.setJdbcUrl("jdbc:mysql://localhost:3306/springdb");
        config.setJdbcUrl("jdbc:log4jdbc:mysql://hyun-9999.asuscomm.com:3377/momentdb");
        config.setUsername("master");
        config.setPassword("11009900");
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;



    }

    @Bean
    public TransactionManager transactionManager(){//트랜잭션 매니저 걸어주기!
        return new DataSourceTransactionManager(dataSource());
    }



}
