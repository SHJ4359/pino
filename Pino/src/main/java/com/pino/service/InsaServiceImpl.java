package com.pino.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pino.domain.InsaComVo;
import com.pino.domain.InsaVo;
import com.pino.domain.PagingDto;
import com.pino.domain.SearchDto;
import com.pino.domain.TestDto;
import com.pino.persistance.InsaDao;

@Service
public class InsaServiceImpl implements InsaService {
	
	@Inject
	InsaDao insaDao;

	@Override
	public void memberInsert(InsaVo insaVo) throws Exception {
//		System.out.println("SERVICE 실행됨");
//		System.out.println("SERVICE insaVo : " + insaVo);
		insaDao.memberInsert(insaVo);
	}

	@Override
	public List<InsaComVo> getInsaCom() throws Exception {
		List<InsaComVo> getInsaCom = insaDao.getInsaCom();
		return getInsaCom;
	}

	@Override
	public int getSabun() throws Exception {
		int getSabun = insaDao.getSabun();
		return getSabun;
	}

	@Override
	public List<InsaVo> getMemberList(SearchDto searchDto) throws Exception {
		List<InsaVo> getMemberList = insaDao.getMemberList(searchDto);
//		System.out.println("service / getMemberList : " + getMemberList);
		return getMemberList;
	}

	@Override
	public InsaVo updateMember(String sabun) throws Exception {
		InsaVo insaVo = insaDao.updateMember(sabun);
		return insaVo;
	}

	@Override
	public void updateMemberAction(InsaVo insaVo) throws Exception {
		insaDao.updateMemberAction(insaVo);
		
	}

	@Override
	public boolean dupId(String id) throws Exception {
		boolean dupId = insaDao.dupId(id);
//		System.out.println("Service dupId : " + dupId);
		return dupId;
	}

	@Override
	public int getMemberCount(SearchDto searchDto) throws Exception {
		int getMemberCount = insaDao.getMemberCount(searchDto);
		return getMemberCount;
	}

}
