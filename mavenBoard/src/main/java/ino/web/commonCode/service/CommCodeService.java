package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

@Service
public class CommCodeService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCodeList() {
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}

	public List<Map<String,Object>> selectDetailCodeList(Map<String,Object> code) {
		
	System.out.println("code = "+code);
		
		return sqlSessionTemplate.selectList("selectCodeList",code);
	}

	public List<HashMap<String, Object>> codeDetail(String code) {
		
		return sqlSessionTemplate.selectList("selectCodeDetail",code);
	}
	

	public int commonCodeInsert(List<Map<String, Object>> insertList) {
		return sqlSessionTemplate.insert("commonCodeInsert",insertList);
	}
	

	public int commonCodeUpdate(List<Map<String, Object>> updateList) {
		return sqlSessionTemplate.update("commonCodeUpdate",updateList);
	}
	
	public int commonCodeDelete(List<Map<String, Object>> deleteList) {
		return sqlSessionTemplate.delete("commonCodeDelete",deleteList);
	}

	public int decodeCheck(List<Map<String, Object>> list) {
		return sqlSessionTemplate.selectOne("decodeCheck",list);
	}

	


	
}
