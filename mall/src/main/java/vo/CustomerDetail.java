package vo;

public class CustomerDetail {
	
	private int customerNo;
	private String customerName;
	private String customerPhone;
	private String createdate;
	private String updatedate;
	
	public int getCustomerNo() {
		return customerNo;
	}
	public String getCustomerName() {
		return customerName;
	}
	public String getCustomerPhone() {
		return customerPhone;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
