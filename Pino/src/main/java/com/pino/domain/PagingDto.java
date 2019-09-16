package com.pino.domain;

public class PagingDto {
	private int nowPage = 1;
	private int perPage = 10;
	private int startRowPage = 1;
	private int endRowPage = startRowPage + perPage - 1;
	
	private void setRow() {
		startRowPage = nowPage * perPage - perPage + 1;
//		System.out.println("startRowPage : " + startRowPage);
		endRowPage = startRowPage + perPage - 1;
//		System.out.println("endRowPage : " + endRowPage);
	}
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		setRow();
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
		setRow();
	}
	public int getStartRowPage() {
		return startRowPage;
	}
	public void setStartRowPage(int startRowPage) {
		this.startRowPage = startRowPage;
	}
	public int getEndRowPage() {
		return endRowPage;
	}
	public void setEndRowPage(int endRowPage) {
		this.endRowPage = endRowPage;
	}
	
	@Override
	public String toString() {
		return "PagingDto [nowPage=" + nowPage + ", perPage=" + perPage + ", startRowPage=" + startRowPage
				+ ", endRowPage=" + endRowPage + "]";
	}
	
}
