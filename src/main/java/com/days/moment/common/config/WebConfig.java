package com.days.moment.common.config;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

@Log4j2
    public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {




        @Override
        protected Class<?>[] getRootConfigClasses() {
            log.info("1------------");
            log.info("1------------");
            return new Class[]{RootConfig.class};
        }

        @Override
        protected Class<?>[] getServletConfigClasses() {
            log.info("2------------");
            log.info("2------------");
            return new Class[]{ServletConfig.class};
        }

        @Override
        protected String[] getServletMappings() {
            return new String[]{"/"};
        }

    @Override
    protected Filter[] getServletFilters() {

        CharacterEncodingFilter utf8Filter = new CharacterEncodingFilter();
        utf8Filter.setEncoding("UTF-8");
        utf8Filter.setForceEncoding(true);

        return new Filter[]{utf8Filter};
        }


    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        registration.setInitParameter("throwExceptionIfNoHandlerFound","true");

        MultipartConfigElement multipartConfigElement
                = new MultipartConfigElement("C:\\upload\\temp", 1024*1024*10, 1024*1024*20, 1024*1024*1);
        //10MB -최대 20MB

        registration.setMultipartConfig((multipartConfigElement));

    }
}
