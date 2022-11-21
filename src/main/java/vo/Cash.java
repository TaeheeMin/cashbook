package vo;

public class Cash {
	private int csahNo;
	// map을 사용안하려면 private Category category로 이너조인으로 받아올수있음 -> Cash타입으로 사용 
	private int categoryNo; // 참조키 이너조인 필요 -> map타입으로 사용
	private long csahPrice;
	private String csahMemo;
	private String updatedate;
	private String createdate;
	
	public int getCsahNo() {
		return csahNo;
	}
	public void setCsahNo(int csahNo) {
		this.csahNo = csahNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public long getCsahPrice() {
		return csahPrice;
	}
	public void setCsahPrice(long csahPrice) {
		this.csahPrice = csahPrice;
	}
	public String getCsahMemo() {
		return csahMemo;
	}
	public void setCsahMemo(String csahMemo) {
		this.csahMemo = csahMemo;
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
