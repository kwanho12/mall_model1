package vo;

public class Customer {
	
	private int customerNo;
	private String customerId;
	private String customerPw;
	private String createdate;
	private String updatedate;
	private String active;
	
	public int getCustomerNo() {
		return customerNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public String getCustomerPw() {
		return customerPw;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public String getActive() {
		return active;
	}
	
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public void setCustomerPw(String customerPw) {
		this.customerPw = customerPw;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
}
