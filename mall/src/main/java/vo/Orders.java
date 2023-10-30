package vo;

public class Orders {

	private int ordersNo;
	private int goodsNo;
	private int customerNo;
	private int customerAddrNo;
	private int quantity;
	private int totalPrice;
	private String ordersState;
	private String createdate;
	private String updatedate;
	
	public int getOrdersNo() {
		return ordersNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public int getCustomerAddrNo() {
		return customerAddrNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public String getOrdersState() {
		return ordersState;
	}
	public String getCreatedate() {
		return createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public void setCustomerAddrNo(int customerAddrNo) {
		this.customerAddrNo = customerAddrNo;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public void setOrdersState(String ordersState) {
		this.ordersState = ordersState;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	
	
}
