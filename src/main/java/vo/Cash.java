package vo;

public class Cash {
	// map을 사용안하려면 private Category category로 이너조인으로 받아올수있음 -> Cash타입으로 사용 
	private int categoryNo; // 참조키 이너조인 필요 -> map타입으로 사용
	private int cashNo;
	private String memberId;
	private String cashDate;
	private long cashPrice; 
	private String cashMemo;
	private String updatedate;
	private String createdate;
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public long getCashPrice() {
		return cashPrice;
	}
	public void setCashPrice(long cashPrice) {
		this.cashPrice = cashPrice;
	}
	public String getCashMemo() {
		return cashMemo;
	}
	public void setCashMemo(String cashMemo) {
		this.cashMemo = cashMemo;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
}
