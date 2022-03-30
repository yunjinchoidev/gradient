package project5.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import project5.member.MemberDao;
import project5.member.MemberService;
import project5.member.MemberVO;
import project5.security.domain.CustomUser;

public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	MemberDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("===========================");
		System.out.println(username);
		// userName means userid
		MemberVO vo = dao.read(username);
		return vo == null ? null : new CustomUser(vo);
	}

}























