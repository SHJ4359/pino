package com.pino.persistance;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pino.domain.InsaComVo;
import com.pino.domain.InsaVo;
import com.pino.domain.PagingDto;
import com.pino.domain.SearchDto;
import com.pino.domain.TestDto;

@Repository
public class InsaDaoImpl implements InsaDao {
	
	@Inject
	SqlSession sqlSession;
	
	private static String NAMESPACE = "insaMapper.";

	@Override
	public void memberInsert(InsaVo insaVo) throws Exception {
//		System.out.println("DAO 실행됨");
//		System.out.println("DAO insaVo : " + insaVo);
		sqlSession.insert(NAMESPACE + "memberInsert", insaVo);
	}

	@Override
	public List<InsaComVo> getInsaCom() throws Exception {
		List<InsaComVo> getInsaCom = sqlSession.selectList(NAMESPACE + "getInsaCom");
//		System.out.println("Dao / selectInsaCom : " + selectInsaCom);
		return getInsaCom;
	}

	@Override
	public int getSabun() throws Exception {
		int getSabun = sqlSession.selectOne(NAMESPACE + "getSabun");
		return getSabun;
	}

	@Override
	public List<InsaVo> getMemberList(SearchDto searchDto) throws Exception {
		
//		HashMap<String, Object> dtoData = new HashMap<>();
//		dtoData.put("searchDto", searchDto);
//		dtoData.put("pagingDto", pagingDto);
//		System.out.println("DAO / dtoData : " + dtoData);
//		System.out.println("DAO / searchDto : " + searchDto);
//		System.out.println("DAO / pagingDto : " + pagingDto);
		
		List<InsaVo> getMemberList = sqlSession.selectList(NAMESPACE + "getMemberList", searchDto);
//		System.out.println("dao / getMemberList : " + getMemberList);
		return getMemberList;
	}

	@Override
	public InsaVo updateMember(String sabun) throws Exception {
		InsaVo insaVo = sqlSession.selectOne(NAMESPACE + "updateMember", sabun);
		return insaVo;
	}

	@Override
	public void updateMemberAction(InsaVo insaVo) throws Exception {
		sqlSession.update(NAMESPACE + "updateMemberAction", insaVo);
		
	}

	@Override
	public boolean dupId(String id) throws Exception {
		boolean result = true;
		int dupId = sqlSession.selectOne(NAMESPACE + "dupId", id);
//		System.out.println("Dao dupId : " + dupId);
		if (dupId == 1) {
			result = true;
		} else if (dupId == 0) {
			result = false;
		}
		return result;
	}

	@Override
	public int getMemberCount(SearchDto searchDto) throws Exception {
		
//		HashMap<String, Object> dtoData = new HashMap<>();
//		dtoData.put("searchDto", searchDto);
//		dtoData.put("pagingDto", pagingDto);
				
		int getMemberCount= sqlSession.selectOne(NAMESPACE + "getMemberCount", searchDto);
		return getMemberCount;
		
	}

}
