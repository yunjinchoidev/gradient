package project5.qualityAttach;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class QualityAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private int qualitykey;

	
	
	public QualityAttachVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QualityAttachVO(String uuid, String uploadPath, String fileName, boolean fileType, int qualitykey) {
		super();
		this.uuid = uuid;
		this.uploadPath = uploadPath;
		this.fileName = fileName;
		this.fileType = fileType;
		this.qualitykey = qualitykey;
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

	public int getQualitykey() {
		return qualitykey;
	}

	public void setQualitykey(int qualitykey) {
		this.qualitykey = qualitykey;
	}

}
