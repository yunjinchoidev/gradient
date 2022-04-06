package project5.noticeAttach;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class NoticeAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private int noticekey;

	
	
	public NoticeAttachVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NoticeAttachVO(String uuid, String uploadPath, String fileName, boolean fileType, int noticekey) {
		super();
		this.uuid = uuid;
		this.uploadPath = uploadPath;
		this.fileName = fileName;
		this.fileType = fileType;
		this.noticekey = noticekey;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public boolean isFileType() {
		return fileType;
	}

	public void setFileType(boolean fileType) {
		this.fileType = fileType;
	}

	public int getNoticekey() {
		return noticekey;
	}

	public void setNoticekey(int noticekey) {
		this.noticekey = noticekey;
	}

}
