package com.pino.domain;

public class TestDto {

	private int totalData;
	
	// 페이징
	private int startRow;
	private int endRow;
	private int perPage = 10; // 컨텐츠 보여질 줄 갯수

	// 페이지네이션
	private int nowPage = 1;
	private int startPage = 1;
	private int endPage;
	private int pagingCount = 10; // 페이지네이션 버튼 갯수 -> 10일 경우 1~10까지
	private boolean prev;
	private boolean next;
	
	//검색 정보
	private String sabun;
	private String name;
	private String join_gbn_code;
	private String put_yn;
	private String pos_gbn_code;
	private String join_day;
	private String retire_day;
	private String job_type;
	
	private void calcPage() {
		int totalPage = totalData/perPage;
		if(totalData%perPage >0) {
			totalPage +=1;
		}
		startPage = ((nowPage-1)/pagingCount)*pagingCount+1;
		endPage = startPage +pagingCount-1;
		
		if(endPage >= totalPage) {
			endPage = totalPage;
			next=false;
		} else {
			next=true;
		}
		
		if(startPage > pagingCount) {
			prev=true;
		} else {
			prev=false;
		}
		
		endRow = nowPage*perPage;
		startRow = endRow -perPage+1;
	}
	
	public int getTotalData() {
		return totalData;
	}

	public void setTotalData(int totalData) {
		this.totalData = totalData;
		calcPage();
	}

	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPagingCount() {
		return pagingCount;
	}
	public void setPagingCount(int pagingCount) {
		this.pagingCount = pagingCount;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}

	public String getSabun() {
		return sabun;
	}

	public void setSabun(String sabun) {
		this.sabun = sabun;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getJoin_gbn_code() {
		return join_gbn_code;
	}

	public void setJoin_gbn_code(String join_gbn_code) {
		this.join_gbn_code = join_gbn_code;
	}

	public String getPut_yn() {
		return put_yn;
	}

	public void setPut_yn(String put_yn) {
		this.put_yn = put_yn;
	}

	public String getPos_gbn_code() {
		return pos_gbn_code;
	}

	public void setPos_gbn_code(String pos_gbn_code) {
		this.pos_gbn_code = pos_gbn_code;
	}

	public String getJoin_day() {
		return join_day;
	}

	public void setJoin_day(String join_day) {
		this.join_day = join_day;
	}

	public String getRetire_day() {
		return retire_day;
	}

	public void setRetire_day(String retire_day) {
		this.retire_day = retire_day;
	}

	public String getJob_type() {
		return job_type;
	}

	public void setJob_type(String job_type) {
		this.job_type = job_type;
	}

	@Override
	public String toString() {
		return "TestDto [totalData=" + totalData + ", startRow=" + startRow + ", endRow=" + endRow + ", perPage="
				+ perPage + ", nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", pagingCount=" + pagingCount + ", prev=" + prev + ", next=" + next + ", sabun=" + sabun + ", name="
				+ name + ", join_gbn_code=" + join_gbn_code + ", put_yn=" + put_yn + ", pos_gbn_code=" + pos_gbn_code
				+ ", join_day=" + join_day + ", retire_day=" + retire_day + ", job_type=" + job_type + "]";
	}
	
}
