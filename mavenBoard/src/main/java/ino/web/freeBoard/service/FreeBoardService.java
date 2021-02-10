package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
//	public List<FreeBoardDto> freeBoardList(Map<String,Object> searchKey){
//		
//		 List<FreeBoardDto> boardList =null;
//		 
//		 if(searchKey.get("searchType")!=null) {
//	        
//	         searchKey.put("searchType", (String) searchKey.get("searchType"));
//	         searchKey.put("keyWord", (String) searchKey.get("keyWord"));
//	         boardList = sqlSessionTemplate.selectList("freeBoardGetList",searchKey);
//	         
//	      }else {
//	         boardList = sqlSessionTemplate.selectList("freeBoardGetList");
//	      }
//	      
//
//			return boardList;
//
//		
//	}
	public List<FreeBoardDto> freeBoardList(Map<String, Object> searchkey){
		
		System.out.println("service="+searchkey);
		
		List<FreeBoardDto> boardList= sqlSessionTemplate.selectList("freeBoardGetList",searchkey);
		return boardList;
}
	
	
	public int freeBoardInsertPro(FreeBoardDto dto){
		int res = 0;
		
		try{	
			res = sqlSessionTemplate.insert("freeBoardInsertPro",dto);
		}catch(Exception e){
			e.printStackTrace();
		}
 		
		return res;
		
	}
	
	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public int freeBoardModify(FreeBoardDto dto){
		int res = sqlSessionTemplate.update("freeBoardModify", dto);
		
		return res;
	}

	public int FreeBoardDelete (int num) {
		int res = sqlSessionTemplate.delete("freeBoardDelete", num);
		return res;
	}
	

	public int countBoard(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("countBoard",map);
	}


	
}
