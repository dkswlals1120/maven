<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">

$( document ).ready(function() {
    
    $("#ajax_btn1").click(function(){
		
		var type=$("#searchType").val();
		var keyword=$("#searchKeyword").val();
		var stDate=$("#stDate").val();
		var enDate=$("#enDate").val();
		var numRegExp =/[^0-9]/gi  ; 
		var keyRegExp =/[^A-Za-z0-9가-힣ㄱ-ㅎ]/gi  ; 
		
		if($("#stDate").val() ==""&& $("#enDate").val()==""){
			if(type=="DCOM001"){
				if(numRegExp.test(keyword)){
					alert("글번호 선택시 검색어는 숫자로 입력해주세요");
					$("#searchKeyword").focus();
					return false;
				}else if(keyword.length==0){
					alert("검색어를 입력해 주세요");
					$("#searchKeyword").focus();
					return false;
				}
			}else{
				if(keyRegExp.test(keyword)||keyword.length==0){
					alert("검색어를 입력해 주세요");
					$("#searchKeyword").focus();
					return false;
				}
			
			}
		}
		
		//날짜 유효성
		var eng = /[a-zA-Z]/;
		var kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var spe = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
		/*var stDate = $("#stDate").val();
		var enDate $("#enDate").val();
		console.log(stDate);
		console.log(enDate);*/

		

		var year1 = stDate.substr(0,4);
		var mon1 = stDate.substr(4,2);
		var mon1ch = (Number(mon1) - 1)+"";
		var il1 = stDate.substr(6,2);
		var year2 = enDate.substr(0,4);
		var mon2 = enDate.substr(4,2);
		var mon2ch = (Number(mon2) - 1)+"";
		var il2 = enDate.substr(6,2);
		
		var startDate = new Date(year1,mon1ch,il1);
		var endDate = new Date(year2,mon2ch,il2);
		//console.log(startDate.toDateString());
	//	console.log(endDate.toDateString());
		/*var year1 = stDate.subString(0,3);
		var mo1 = stDate.subString(4,6);
		var il1 = stDate.subString(6,8);
		
		var year2 = enDate.subString(0,3);
		var mo2 = enDate.subString(4,6);
		var il2 = enDate.subString(6,8);
		
		var startDate = new Date(stDate);
		console.log(startDate);
		var endDate = new Date(enDate);*/
		
		startDate.setMonth(startDate.getMonth()+1);
		alert(endDate.getTime());
		alert(startDate.getTime());
		if(eng.test(stDate)||kor.test(stDate)||spe.test(stDate)){
			alert("숫자만 입력하세요");
			return false;
		}else if(stDate > enDate){
			alert("시작날짜는 마감날짜보다 작아야합니다.");
			return false;
		}else if( endDate.getTime() > startDate.getTime()){
			alert("시작날짜와 마감날짜는 한달 이내여야합니다.");
			return false;
		}



	
		//맵 선언 
		
		/*searchkey["serach_option"] = "search";*/
		/*var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		
		/*/
		/* var searchkey = {
				"searchType" : $("#searchType").val(),
				"searchKeyword" : $("#searchKeyword").val()
		}; */
		
		$.ajax({
			url:"./ajax.ino",
			type:"POST",
			dataType:"json",
			data: {"searchType" : $("#searchType").val() ,"searchKeyword" : $("#searchKeyword").val()
				,"stDate" : $("#stDate").val(),"enDate" : $("#enDate").val()},
		     success : function(resdata) {
		    	 console.log(resdata);
		    	var list = resdata.list
		   		console.log(list);
		    	 
		    	var page = resdata.paging
		    	console.log(page);

		    	
							    	 
		    	
		    
		   	if(list.length>0){ 
		    	 $("#mainList").empty();
		    	 $("#page").empty();
				
		   		 
			
		   $.each(list, function(i,v){ 
			   $('#mainList').append(
						 "<tr>"+
						 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+v.codeType+"</td>"+
						 	"<td style='width: 50px; padding-left: 10px;' align='center'>"+v.num+"</td>"+
						 	"<td style='width: 125px;' align='center'>"+"<a href=./freeBoardDetail.ino?num="+v.num +">"+v.title+"</td>"+
						 	"<td style='width: 48px; padding-left: 50px;' align='center'>"+v.name+"</td>"+
						 	"<td style='width: 100px; padding-left: 95px;' align='center'>"+v.regdate+"</td>"+
						 "</tr>"
						 );
		   }); // end f
		   
		   /*var qwe = '<a href="./main.ino?nowPage='+page.startPage+'&searchType='+resdata.searchType+'&searchKeyword='+resdata.searchKeyword+'">[처음]</a>';
		   var zxc =  '<a href="./main.ino?nowPage'+page.nowPage-1+'&cntPerPage='+page.cntPerPage+'&searchType='+resdata.searchType+'&searchKeyword='+resdata.searchKeyword+'">[이전]</a>';	  
		   	 if(resdata.searchType == 'DCOM002'){
		   		$('#page').append(qwe);
		   	 }
		   		
		   
			  if(page.nowPage != page.startPage ){
				  
				  $('#page').append(zxc); 
			  }
				  for(var i=page.startPage;i <= page.endPage; i++){
					  if(i == page.nowPage){
						  $('#page').append('<b>'+i+'</b>');
					  }else if(i != page.nowPage){
						  $('#page').append('<a href="./main.ino?nowPage='+i+'&cntPerPage='+page.cntPerPage+'&searchType='+resdata.searchType+'&searchKeyword='+resdata.searchKeyword+'">'+i+'</a>&nbsp;');
					  }
				  }  
 
			  
			  if(page.nowPage != page.lastPage && resdata.searchType == 'DCOM002'){
				  $('#page').append('<a href="./main.ino?nowPage='+page.nowPage+'&cntPerPage='+page.cntPerPage+'&searchType='+resdata.searchType+'&searchKeyword='+resdata.searchKeyword+'">[다음]</a>');
			  }
			  
			  if(resdata.searchType == 'DCOM002'){	  
				  $('#page').append('<a href="./main.ino?nowPage='+page.lastPage+'&searchType='+resdata.searchType+'&searchKeyword='+resdata.searchKeyword+'">[끝]</a>');
			  }*/
			  
			  var str ="";
			  if(resdata.searchType == 'DCOM002' && page.nowPage != page.lastPage){
			  str += "<a href='./main.ino?nowPage="+page.startPage+"&searchType="+resdata.searchType+"&searchKeyword="+resdata.searchKeyword+"&stDate="+resdata.stDate+"&enDate="+resdata.enDate+"'>";
			  str += "[처음]"
			  str += "</a>";
			  }
			  if(page.nowPage != page.startPage ){
			  str += "<a href='./main.ino?nowPage="+page.nowPage-1+"&cntPerPage="+page.cntPerPage+"&searchType="+resdata.searchType+"&searchKeyword="+resdata.searchKeyword+"&stDate="+resdata.stDate+"&enDate="+resdata.enDate+"'>";
			  str += "[이전]";
			  str += "</a>";  
			  }
			  for(var i=page.startPage;i <= page.endPage; i++){
				  if(i == page.nowPage){
					  str += "<b>"
					  str += i
					  str += "</b>&nbsp;"
				  }else if(i != page.nowPage){
					  str += "<a href='./main.ino?nowPage="+i+"&cntPerPage="+page.cntPerPage+"&searchType="+resdata.searchType+"&searchKeyword="+resdata.searchKeyword+"&stDate="+resdata.stDate+"&enDate="+resdata.enDate+"'>"
					  str += i
					  str += "</a>&nbsp;"
				  }
			  }
			  if(page.nowPage != page.lastPage && resdata.searchType == 'DCOM002'){
				  str += "<a href='./main.ino?nowPage="+page.nowPage+"&cntPerPage="+page.cntPerPage+"&searchType="+resdata.searchType+"&searchKeyword="+resdata.searchKeyword+"&stDate="+resdata.stDate+"&enDate="+resdata.enDate+"'>"
				  str += "[다음]"
				  str += "</a>"
			  }
			  if(resdata.searchType == 'DCOM002' && page.nowPage != page.lastPage){
				  str += "<a href='./main.ino?nowPage="+page.lastPage+"&searchType="+resdata.searchType+"&searchKeyword="+resdata.searchKeyword+"&stDate="+resdata.stDate+"&enDate="+resdata.enDate+"'>"
				  str += "[끝]"
				  str += "</a>"
			  }
			  
			  document.getElementById("page").innerHTML = str;
			  
		    }else{
		    	$("#mainList").empty();
		    	 $("#mainList").append("<div>"+"검색 결과가 없습니다."+"<div>");
		    	 $("#page").empty();
		    }
		    	
		   	

		     },
		     error : function( e,errorThrown  ) {
				console.log(e);
		    	console.log(errorThrown);
		    	

		    	}
		});//ajax end
});//이벤트 끝

$("#serach_keyword").keypress(function(e){
	if(e.which ==13 ){
		$("#ajax_btn1").click();
		return false; 
		
	}//검색어를 입력하는 input태그 안에서 키를 누르는 이벤트가 일어날 경우 그 엔터키가 눌렸는지 구분하여  ajax_btn1 클릭 이벤트를 실행 한다 위의   
	//그리고 아래 return false;  주는 이유는 혹시 다른 작업을 타고들어가는 것을 막기 위해서
	
});//keypress end
});
/*
 * 
 var frm = $("#frm").serialize();
 ./main.ino?searchType=num&keyWord=assdfdf;
 
 $.ajax({
	 url: "", // ajax가 호출할 url > form > action ex: "./main.ino" 
	 type: "", // method >> GET , POST  
	 dataType: "", json >> 배열 {key : value}
	 data: "", 파라미터 {"searchType" : num , "keyWord" : assdfdf } > serialize 폼전체를 직렬화
	 success: function(data){
		 
		 // ajax가 소통하고있는 (java controller)서버와 정상적으로 성공했을때
		 // function(data) >> 서버에서 전달해준 data
		 // freeBoardList > data.freeBoardList;
		 // 리스트 표현방식은 html 로 표현합니다. 
		 
		 data.freeBoardList
		 
		 var html = "";
		 html += "<td>'+data.freeBoardList+''</td>";
		 
		 
	 },
	 error: function (request, status, error){
		 // 서버와 정상적으로 소통하지 않았을때 
		 console.log(status) , alert(error)
		 
	 }
	});
 */
 
 //새로 시작
 /*function search(){
	var searchType= $('#searchType').serialize();
	var keyWord = $('#keyWord').serialize();
	
	var searchKey = {
		"searchType" : searchType,
		"keyWord" : keyWord
	};
	console.log(searchKey);
	
	 $.ajax({
		 url: "./search.ino",
		 type: "POST",
		 data: JSON.stringify(searchKey),
		 success: function(data,status){
			 	console.log(data);
				 $('#tbody').empty();
				 $.each(JSON.parse[data],function(key,val){
					 var list = val;
					 for(var i=0;i<list.length;i++){
						 var str = list[i];
					 $('#tbody').append(
							 "<tr>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.codeType+"</td>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.num+"</td>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.name+"</td>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.title+"</td>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.content+"</td>"+
							 	"<td style='width: 55px; padding-left: 30px;' align='center'>"+str.regdate+"</td>"+
							 "</tr>"
							 );
					 }
				 })

		 },
		 error: function (request,status,error,e,errorThrown){
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			 console.log(e);
			 console.log(errorThrown);
		 }
		 });
 }	*/
 $(function() {
	 

		
		
});//function end
 
/* function selChange() {
	var sel = document.getElementById('cntPerPage').value;
	location.href="/main.ino?nowPage=${paging.nowPage}&cntPerPage="+sel;
} */ 

 	
</script>

</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<!-- 했던 것 <form action="./search.ino" method="POST">
		<div>
			<select id="searchType" name="searchType">
				<option value="num">글번호</option>
				<option value="title">글제목</option>
			</select>
			<input type="text" id="keyWord" name="keyWord"/>
			<input type="button" value="검색" onclick="search();"/>
		</div>
	</form>-->
	<form id="frm" name="frm">
		<div>
				
				 <span>
					<select id="searchType" name="searchType">
							<option value="">전체 보기</option>
						<c:forEach var="nWoe" items="${listW }">
							<option value="${nWoe.DECODE }">${nWoe.DECODE_NAME}</option>
						</c:forEach>
					</select>
				
				</span> 
					
				<span>
					<select id="searchYear" name="searchYear">
						<c:forEach var="nRow" items="${listY}" >
							<option value="${nRow.DECODE }">${nRow.DECODE_NAME}</option>
						</c:forEach>
					</select>
				</span>
					
					검색어:<input type="text" id="searchKeyword" name="searchKeyword">
					<input type="button" id="ajax_btn1" value="검색" /><br>
					시작 날짜 : <input type="text" name="stDate" id="stDate" placeholder="'20200101' 형식 입력" maxlength="8"/>~
					마감 날짜 : <input type="text" name="enDate" id="enDate" placeholder="'20200101' 형식 입력" maxlength="8"/>
					 
				
			</div>
		</form>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>

	
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead id="thead">
				<tr>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">
		<!-- 추가 --><!-- 추가 -->

	<div>
		<table border="1">
			<tbody id="mainList">
					<c:forEach var="dto" items="${freeBoardList }">
					 <tr>
						<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
						<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
						<td style="width: 125px; "align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
						<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
						<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
					<tr>
					</c:forEach>
			</tbody>
		</table>
	
		<div style="display: block; text-align: center;" id="page">
			<a href="./main.ino?nowPage=1&searchType=${map.searchType}&searchKeyword=${map.searchKeyword }&stDate=${map.stDate }&enDate=${map.enDate }">[처음]</a>	
			<c:if test="${paging.nowPage != paging.startPage }">
			<a href="./main.ino?nowPage=${paging.nowPage - 1 }&cntPerPage=${paging.cntPerPage}&searchType=${map.searchType}&searchKeyword=${map.searchKeyword }&stDate=${map.stDate }&enDate=${map.enDate }" >[이전]</a>
			</c:if>
		
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="./main.ino?nowPage=${p}&cntPerPage=${paging.cntPerPage}&searchType=${map.searchType}&searchKeyword=${map.searchKeyword }&stDate=${map.stDate }&enDate=${map.enDate }">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.nowPage != paging.lastPage }">
			<a href="./main.ino?nowPage=${paging.nowPage+ 1}&cntPerPage=${paging.cntPerPage}&searchType=${map.searchType}&searchKeyword=${map.searchKeyword }&stDate=${map.stDate }&enDate=${map.enDate }" >[다음]</a>
		</c:if>	
			<a href="./main.ino?nowPage=${paging.lastPage}&searchType=${map.searchType}&searchKeyword=${map.searchKeyword }&stDate=${map.stDate }&enDate=${map.enDate } "  >[끝]</a>
	</div> 
	


	</div>
	
</body>
</html>