package com.javaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.javaweb.DTO.MyAccount;
import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.AccountEntity;
import com.javaweb.entity.RoleEntity;
import com.javaweb.repository.AccountRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private AccountRepository accountRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AccountEntity accountEntity = accountRepository.findOneByUsernameAndStatus(username,
				SystemConstant.ACTIVE_STATUS);
		if (accountEntity == null) {
			throw new UsernameNotFoundException("user not found");

		}
		List<GrantedAuthority> authorities = new ArrayList<>();
		for (RoleEntity role : accountEntity.getRoles()) {
			authorities.add(new SimpleGrantedAuthority(role.getCode())); // code: ADMIN; USER
		}

		// = SECCION o jdbc servlet
		/*
		 * User user = new User(accountEntity.getUsername(),
		 * accountEntity.getPassword(), true, true, true, true, authorities );
		 */
		// custom MyAccount extend User of Spring to getFullname (DTO)
		// put thong tin vao spring security => duy tri thong tin khi login vao he thong(Pricipal)
		// put thong tin vao myAccount
		// chuyen sang securityutils xu li tiep => customsuccess
		MyAccount myAccount = new MyAccount(accountEntity.getUsername(), accountEntity.getPassword(), true, true, true,
				true, authorities);
		myAccount.setFullname(accountEntity.getFullname());
		return myAccount;
	}

}
