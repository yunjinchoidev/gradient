package springweb.a03_sec.custom2;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import springweb.a03_sec.custom.UserInfo;
import springweb.a03_sec.custom.UserPermission;
// springweb.a03_sec.custom2.CustomAuthenticationProvider
@Service
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		UsernamePasswordAuthenticationToken authToken = (UsernamePasswordAuthenticationToken) authentication;

		UserInfo userInfo = findUserById(authToken.getName());
		if (userInfo == null) {
			throw new UsernameNotFoundException(authToken.getName());
		}

		if (!matchPassword(userInfo.getPassword(), authToken.getCredentials())) {
			throw new BadCredentialsException("not matching username or password");
		}

		List<GrantedAuthority> authorities = getAuthorities(userInfo.getId());
		return new UsernamePasswordAuthenticationToken(
				new UserInfo(userInfo.getId(), userInfo.getName(), null),
				null,
				authorities);
	}

	private UserInfo findUserById(String id) {
		return userMap.get(id);
	}

	private List<GrantedAuthority> getAuthorities(String id) {
		List<UserPermission> perms = permMap.get(id);
		if (perms == null)
			return Collections.emptyList();

		List<GrantedAuthority> authorities = new ArrayList<>(perms.size());
		for (UserPermission perm : perms) {
			authorities.add(new SimpleGrantedAuthority(perm.getName()));
		}
		return authorities;
	}

	private boolean matchPassword(String password, Object credentials) {
		return password.equals(credentials);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

	private Map<String, UserInfo> userMap = new HashMap<>();
	private Map<String, List<UserPermission>> permMap = new HashMap<>();

	public CustomAuthenticationProvider() {
		userMap.put("cron", new UserInfo("cron", "스케줄러", "cronpw"));
		permMap.put("cron", Arrays.asList(new UserPermission(1L, "SCHEDULER")));
	}

}
