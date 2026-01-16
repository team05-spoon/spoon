package com.spoon.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.spoon.dao.memberDAO;
import com.spoon.dto.memberDTO;

import jakarta.servlet.DispatcherType;

@Configuration
public class webSecurityConfig {

    @Autowired
    private memberDAO memberDAO;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http.csrf((csrf) -> csrf.disable())
            .cors((cors) -> cors.disable())
            .authorizeHttpRequests(request -> request
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                .requestMatchers("/", "/member/memberloginForm", "/member/memberwriteForm", "/member/memberwrite", "/item/itemlist","/jusoPopup").permitAll()
                .requestMatchers("/css/**", "/js/**", "/timages/**", "/dimages/**").permitAll()
                .requestMatchers("/member/**", "/seller/**", "/board/**", "/notice/list", "/notice/detail", "/cart/**", "/item/**","mainpage/**","/payments/**")
                    .hasAnyRole("USER", "SELLER", "ADMIN")
                .requestMatchers("/notice/write").hasRole("ADMIN")
                .anyRequest().authenticated()
            );

        http.formLogin((formLogin) -> formLogin
            .loginPage("/member/memberloginForm")
            .loginProcessingUrl("/m_spring_security_check")
            .usernameParameter("m_username")
            .passwordParameter("m_password")
            .successHandler((request, response, authentication) -> {
                String m_id = authentication.getName(); // ✅ 로그인 ID
                memberDTO member = memberDAO.findByMid(m_id);

                // ✅ 세션에 저장 (board에서 loginMember로 체크 가능)
                request.getSession().setAttribute("loginMember", member);

                response.sendRedirect("/");
            })
            .failureUrl("/member/memberloginForm?error")
            .permitAll()
        );

        http.logout((logout) -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/")
            .permitAll()
        );

        return http.build();
    }
}

