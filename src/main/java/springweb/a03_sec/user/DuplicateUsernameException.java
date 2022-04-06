package springweb.a03_sec.user;

@SuppressWarnings("serial")
public class DuplicateUsernameException extends RuntimeException {

	public DuplicateUsernameException(String msg, Exception ex) {
		super(msg, ex);
	}

}
