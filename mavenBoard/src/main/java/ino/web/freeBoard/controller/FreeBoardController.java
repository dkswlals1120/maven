

package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.common.util.PagingVo;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	// DI 
	@Autowired
	private  CommCodeService commCodeService;
	
	
	@RequestMapping(value="/main.ino")
	@ResponseBody
	public ModelAndView main(PagingVo vo
						  ,	 @RequestParam(defaultValue = "") String searchType 
			              ,  @RequestParam(defaultValue = "") String searchKeyword
			              ,  @RequestParam(value="nowPage", required=false)String nowPage
			      		  ,  @RequestParam(value="cntPerPage", required=false)String cntPerPage
				      	  ,  @RequestParam(defaultValue = "") String stDate
				      	  ,  @RequestParam(defaultValue = "") String enDate){
			
			System.out.println("searchType="+searchType);
			System.out.println("searchKeyword="+searchKeyword);
			System.out.println("start="+vo.getStart());
			System.out.println("end="+vo.getEnd());
			System.out.println("nowPage="+nowPage);
			System.out.println("cntPerPage="+cntPerPage);
			System.out.println("stDate="+stDate);
			System.out.println("enDate="+enDate);
			
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			map.put("stDate", stDate);
			map.put("enDate",enDate);
			
			int total = freeBoardService.countBoard(map);
			System.out.println("db접근 후 nowPage="+nowPage);
			System.out.println("db접근 후 cntPerPage="+cntPerPage);
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) { 
				cntPerPage = "10";
			}
			vo = new PagingVo(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			ModelAndView mav = new ModelAndView();
			
			map.put("start", vo.getStart());
			map.put("end", vo.getEnd());
			
			System.out.println("stDate = "+stDate+"enDate = "+enDate);
		

		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
//		List<Map<String,Object>> listY = commCodeService.selectDetailCodeList();
		
		mav.setViewName("boardMain");
		mav.addObject("paging",vo);
		mav.addObject("freeBoardList",list);
		mav.addObject("map",map);
		//
		map.put("code","COM002");
		map.put("use_yn", "Y");
		mav.addObject("listY",commCodeService.selectDetailCodeList(map));
		map.put("code","COM087");
		map.put("use_yn", "Y");
		mav.addObject("listW",commCodeService.selectDetailCodeList(map));
//		mav.addObject("listY",listY);
//		model.addAttribute("paging", vo);
//		model.addAttribute("viewAll", boardService.selectBoard(vo));
		
		
		return mav;
	}
	
	//ajax 받는 컨트롤러 
	@RequestMapping(value="/ajax.ino")
	@ResponseBody
	public Map<String,Object> ajax_main(PagingVo vo
										,  @RequestParam(defaultValue = "") String searchType 
            							,  @RequestParam(defaultValue = "") String searchKeyword 
            							,  @RequestParam(value="nowPage", required=false)String nowPage
            				      		,  @RequestParam(value="cntPerPage", required=false)String cntPerPage
            				      		,  @RequestParam(defaultValue = "") String stDate
            				      		,  @RequestParam(defaultValue = "") String enDate) {
			System.out.println("ajax searchType="+searchType);
			System.out.println("ajax searchKeyword="+searchKeyword);
			System.out.println("ajax nowPage="+nowPage);
			System.out.println("ajax cntPerPage="+cntPerPage);
			System.out.println("ajax stDate="+stDate);
			System.out.println("ajax enDate="+enDate);
			
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			map.put("stDate", stDate);
			map.put("enDate",enDate);
			
			
			int total = freeBoardService.countBoard(map);
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) { 
				cntPerPage = "10";
			}
			vo = new PagingVo(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		
			
			map.put("start", vo.getStart());
			map.put("end", vo.getEnd());
			System.out.println("stDate = "+stDate+"enDate = "+enDate);
			
			List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
			
			map.put("list", list);
			map.put("paging", vo);
			map.put("searchType",searchType);
			map.put("code","COM002");
			map.put("use_yn", "Y");
			map.put("listY",commCodeService.selectDetailCodeList(map));
			map.put("code","COM087");
			map.put("use_yn", "Y");
			map.put("listW",commCodeService.selectDetailCodeList(map));
			/*System.out.println("com087 = "+commCodeService.selectDetailCodeList("COM087"));*/
			
			return map;
		
	}
		
		
		
	
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(Model model){
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("code", "COM890");
		map.put("use_yn", "Y");
		
		model.addAttribute("listT",commCodeService.selectDetailCodeList(map));
		
		return "freeBoardInsert";
	}
	
	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public Map<String,Object> freeBoardInsertPro(FreeBoardDto dto){
		
//		detail로 넘어가는 코드		
//		freeBoardService.freeBoardInsertPro(dto);
//		int res = freeBoardService.getNewNum();
//		dto.setNum(res);
//		return "redirect:freeBoardDetail.ino?num="+dto.getNum();
		
		Map<String,Object> map = new HashMap<String,Object>();
		int res = freeBoardService.freeBoardInsertPro(dto);
		map.put("res",res);
		map.put("code", "COM890");
		map.put("use_yn", "Y");
		map.put("listT", commCodeService.selectDetailCodeList(map));
		
		return map;
		
	}
	
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,int num){
		ModelAndView mav = new ModelAndView();
		FreeBoardDto dto = freeBoardService.getDetailByNum(num);
		
		mav.setViewName("freeBoardDetail");
		mav.addObject("freeBoardDto",dto);
		
		
		return mav;
//		return new ModelAndView("freeBoardDetail", "freeBoardDto", null);
	}
	
	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public Map<String,Object> freeBoardModify(FreeBoardDto dto){
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		
		int res = freeBoardService.freeBoardModify(dto);
		map.put("res", res);
		
		return map;
	}
	
		
	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public Map<String,Object> FreeBoardDelete(int num){
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		int res = freeBoardService.FreeBoardDelete(num);
		map.put("res", res);
		
		return map;
	}
}