package ino.web.commonCode.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;

@Controller
public class CommCodeController {
	
	@Autowired 
	private CommCodeService commCodeService;
	@Autowired
	DataSource dataSource;

	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
		
		List<HashMap<String,Object>> list = commCodeService.selectCommonCodeList();
		
		mav.addObject("list" , list);
		mav.setViewName("commonCodeMain");
		
		return mav;
	}
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView commonCodeDetail(@RequestParam(defaultValue = "") String code){
		ModelAndView mav = new ModelAndView();
		
		List<HashMap<String,Object>> listD = commCodeService.codeDetail(code);
		
		mav.addObject("listD",listD);
		mav.addObject("code",code);
		mav.setViewName("commonCodeInsert");
		
		return mav;
	}
	
	
	@RequestMapping("/commonCodeInsert.ino")
	@ResponseBody
//	@ExceptionHandler(value = Exception.class)
//	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public Map<String,Object> commonCodeInsert(@RequestBody List<Map<String,Object>> list
										){
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
		TransactionStatus sts = txManager.getTransaction(def);
		
					
						Map<String,Object> map = new HashMap<String,Object>();		
						try{
							List<Map<String,Object>> insertList = new ArrayList<Map<String,Object>>();
							List<Map<String,Object>> updateList = new ArrayList<Map<String,Object>>();
							List<Map<String,Object>> deleteList = new ArrayList<Map<String,Object>>();
							
							for(Map<String, Object> addMap:list){
								if(addMap.get("chName").equals("checkSub")) {
									insertList.add(addMap);
								}else if(addMap.get("chName").equals("U")){
									updateList.add(addMap);
								}else if(addMap.get("chName").equals("D")){
									deleteList.add(addMap);
								}
							}
								
							int res = 0;
								if(insertList.size() > 0){
									int res2 = commCodeService.decodeCheck(insertList);
									if(res2 >= 1){
										map.put("res2", res2);
										return map;
									}else{
										commCodeService.commonCodeInsert(insertList);
									}
								}
								if(updateList.size() > 0){
									commCodeService.commonCodeUpdate(updateList);
								}
								if(deleteList.size() > 0){
									commCodeService.commonCodeDelete(deleteList);
								}
								
							map.put("count", 1);
							if (res == (insertList.size()+updateList.size()+deleteList.size())) {
							         map.put("count", 0);
						      }
						}catch(Exception e){
						     e.printStackTrace();
							 txManager.rollback(sts);
						}
	
							txManager.commit(sts);
							return map;	
			}

		}
		