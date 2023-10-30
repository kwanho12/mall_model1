package vo;

public class Notice {

	private int noticeNo;
	private int managerNo;
	private String noticeTitle;
	private String noticeContent;
	private String createdate;
	private String updatedate;
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public int getManagerNo() {
		return managerNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public void setManagerNo(int managerNo) {
		this.managerNo = managerNo;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
