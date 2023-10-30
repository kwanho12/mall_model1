package vo;

public class Question {

	private int questionNo;
	private int goodsNo;
	private int customerNo;
	private String questionTitle;
	private String questionContent;
	private String createdate;
	private String updatedate;
	
	public int getQuestionNo() {
		return questionNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public String getQuestionContent() {
		return questionContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
