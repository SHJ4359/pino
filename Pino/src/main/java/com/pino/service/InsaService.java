package com.pino.service;

import java.util.List;
import java.util.Map;

import com.pino.domain.InsaComVo;
import com.pino.domain.InsaVo;
import com.pino.domain.PagingDto;
import com.pino.domain.SearchDto;
import com.pino.domain.TestDto;

public interface InsaService {
	// 직원 추가
	public void memberInsert(InsaVo insaVo) throws Exception;
	
	// 공통 항목 리스트 불러오기
	public List<InsaComVo> getInsaCom() throws Exception;
	
	// 사번 불러오기
	public int getSabun() throws Exception;
	
	// 직원 리스트 불러오기
	public List<InsaVo> getMemberList(SearchDto searchDto) throws Exception;
	
	// 직원 수 불러오기
	public int getMemberCount(SearchDto searchDto) throws Exception;
	
	// 직원 수정 목록 불러오기
	public InsaVo updateMember(String sabun) throws Exception;
	
	// 직원 수정 실행
	public void updateMemberAction(InsaVo insaVo) throws Exception;	

	// 아이디 중복 체크
	public boolean dupId(String id) throws Exception;
}
