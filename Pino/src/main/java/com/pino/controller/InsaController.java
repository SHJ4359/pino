package com.pino.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.hamcrest.core.SubstringMatcher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ser.std.InetSocketAddressSerializer;
import com.pino.domain.ImageDto;
import com.pino.domain.InsaComVo;
import com.pino.domain.InsaVo;
import com.pino.domain.PaginationDto;
import com.pino.domain.PagingDto;
import com.pino.domain.SearchDto;
import com.pino.domain.TestDto;
import com.pino.service.InsaService;

@Controller
@RequestMapping("/insa/*")
public class InsaController {
	
	@Inject
	InsaService insaService;

	// 직원 등록 폼
	@RequestMapping(value="/input", method = RequestMethod.GET)
	public void memberInput(Model model) throws Exception {
		
		List<InsaComVo> getInsaCom = insaService.getInsaCom();
		model.addAttribute("getInsaCom", getInsaCom);
//		System.out.println(getInsaCom);
		
		int getSabun = insaService.getSabun();
		model.addAttribute("sabun", getSabun);
		
	}
	
	// 직원 등록
	@RequestMapping(value="/input", method = RequestMethod.POST)
	public String memberInput(InsaVo insaVo, RedirectAttributes rttr) throws Exception {
//		System.out.println("실행됨.");
//		System.out.println("insaVo: " + insaVo);
//		System.out.println("map : " + map);
		insaService.memberInsert(insaVo);
		rttr.addFlashAttribute("message", "success_input");
		return "redirect:/insa/input";
	}
	
	// 직원 등록 폼(테스트)
	@RequestMapping(value="/member_input", method = RequestMethod.GET)
	public void memberInputTest() throws Exception {
		
	}
	
	// 직원 조회 폼
	@RequestMapping(value="/select", method = RequestMethod.GET)
	public void memberSelect(SearchDto searchDto, PagingDto pagingDto, TestDto testDto, Model model) throws Exception {
//		System.out.println("select 실행됨");
		List<InsaComVo> getInsaCom = insaService.getInsaCom();
		model.addAttribute("getInsaCom", getInsaCom);
		
		List<InsaVo> getMemberList = insaService.getMemberList(searchDto);
		model.addAttribute("getMemberList", getMemberList);
//		System.out.println("controller / memberList : " + getMemberList);
		
//		int getMemberCount = insaService.getMemberCount(searchDto);
//		testDto.setTotalData(getMemberCount);
//		model.addAttribute("memberCount", testDto);
//		System.out.println("getMemberCount : " + getMemberCount);
	}
	
	// 직원 수정 폼
	@RequestMapping(value="/update", method = RequestMethod.GET)
	public void updateForm(@RequestParam("sabun") String sabun, Model model) throws Exception {
		InsaVo insaVo = insaService.updateMember(sabun);
//		System.out.println("insaVo : " + insaVo);
		
		String email = insaVo.getEmail();
//		System.out.println("email : " + email);
		int number = email.lastIndexOf("@");
//		System.out.println("number : " + number);
		String strEmail = email.substring(0, number);
		insaVo.setEmail(strEmail);
		
		ImageDto imageDto = new ImageDto();
		String carrier = insaVo.getCarrier();
		String cmpImage = insaVo.getCmp_reg_image();
		int carriUnderIndex = carrier.indexOf("_", 1); 
		String showCarrier = carrier.substring(carriUnderIndex + 1);
		
		int cmpUnderIndex = cmpImage.indexOf("_", 1);
		String showCmpImage = cmpImage.substring(cmpUnderIndex + 1);
		
		imageDto.setCarrierName(showCarrier);
		imageDto.setCmpName(showCmpImage);
		model.addAttribute("imageDto", imageDto);
		
		model.addAttribute("insaVo", insaVo);
		
		List<InsaComVo> getInsaCom = insaService.getInsaCom();
		model.addAttribute("getInsaCom", getInsaCom);
		
		model.addAttribute("sabun", sabun);
	}
	
	// 직원 수정 실행
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String updateMemberAction(@RequestParam("sabun") String sabun, InsaVo insaVo) throws Exception {
		insaService.updateMemberAction(insaVo);
		return "redirect:/insa/select";
	}
	
	// 아이디 중복 체크
	@RequestMapping(value="/dup_id", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> dupId(@RequestBody String id) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			boolean checkId = insaService.dupId(id);
//			System.out.println("컨트롤러 checkId : " + checkId);
			if (checkId == true) {
				entity = new ResponseEntity<String>("fail", HttpStatus.OK);
			} else if (checkId == false) {
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
