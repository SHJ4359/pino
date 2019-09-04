package com.pino.domain;

public class PaginationDto {
	private int totalData;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int pagingCount = 10;
	private SearchDto searchDto;
	private PagingDto pagingDto;
	
	private void calcPagination() {
		int perPage = pagingDto.getPerPage();
		int nowPage = pagingDto.getNowPage();
//		System.out.println("perPage : " + perPage);
//		System.out.println("nowPage : " + nowPage);
		
		int paginationCount = totalData / perPage;
		if (totalData % perPage > 0) {
			paginationCount += 1;
		}
//		System.out.println("paginationCount : " + paginationCount);
		
		startPage = ((nowPage -1)/perPage) * perPage + 1;
		endPage = startPage + perPage - 1;
//		System.out.println("startPage : " + startPage);
//		System.out.println("endPage : " + endPage);
		
		if(endPage >= paginationCount) {
			endPage = paginationCount;
			next = false;
		} else {
			next = true;
		}
		
		if(startPage > perPage) {
			prev = true;
		} else {
			prev = false;
		}

	}

	public int getTotalData() {
		return totalData;
	}

	public void setTotalData(int totalData) {
		this.totalData = totalData;
		calcPagination();
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

	public int getPagingCount() {
		return pagingCount;
	}

	public void setPagingCount(int pagingCount) {
		this.pagingCount = pagingCount;
	}

	public SearchDto getSearchDto() {
		return searchDto;
	}

	public void setSearchDto(SearchDto searchDto) {
		this.searchDto = searchDto;
	}

	public PagingDto getPagingDto() {
		return pagingDto;
	}

	public void setPagingDto(PagingDto pagingDto) {
		this.pagingDto = pagingDto;
	}

	@Override
	public String toString() {
		return "PaginationDto [totalData=" + totalData + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", pagingCount=" + pagingCount + ", searchDto=" + searchDto + ", pagingDto="
				+ pagingDto + "]";
	}
	
}
