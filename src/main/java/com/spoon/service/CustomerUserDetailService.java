package com.spoon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spoon.dao.memberDAO;
import com.spoon.dto.memberDTO;

@Service
public class CustomerUserDetailService implements UserDetailsService{

	@Autowired
	private memberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        memberDTO dto = dao.findByMid(username);
        if (dto == null) {
            throw new UsernameNotFoundException("사용자 없음");
        }
		
		return User.builder()
				.username(dto.getM_id())
				.password(dto.getM_pw())
				.roles(dto.getM_temp())
				.build();
	}
}
