package project5.chatBot;




public class ChatBotVO {
	private int chatbotkey;
	private String inputdata;
	private String contents;

	public ChatBotVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatBotVO(int chatbotkey, String inputdata, String contents) {
		super();
		this.chatbotkey = chatbotkey;
		this.inputdata = inputdata;
		this.contents = contents;
	}

	public int getChatbotkey() {
		return chatbotkey;
	}

	public void setChatbotkey(int chatbotkey) {
		this.chatbotkey = chatbotkey;
	}

	public String getInputdata() {
		return inputdata;
	}

	public void setInputdata(String inputdata) {
		this.inputdata = inputdata;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

}
