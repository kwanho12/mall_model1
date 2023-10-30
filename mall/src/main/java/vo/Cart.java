package vo;

public class Cart {
	
	private int cartNo;
	private int goodsNo;
	private int customerNo;
	private int quantity;
	private String createdate;
	private String updatedate;
	
	public int getCartNO() {
		return cartNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setCartNO(int cartNO) {
		this.cartNo = cartNO;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
