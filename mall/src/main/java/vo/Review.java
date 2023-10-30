package vo;

public class Review {

	private int reviewNo;
	private int ordersNo;
	private String reviewContent;
	private String createdate;
	private String updatedate;
	
	public int getReviewNo() {
		return reviewNo;
	}
	public int getOrdersNo() {
		return ordersNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
