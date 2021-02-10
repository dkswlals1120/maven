<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
		
$(document).ready(function(){
			var count = 10000;
			$("#insert").click(function(){
					
					
					 $("#tfoot").append(
							 "<tr>"+
							 "<td>"+
							 "<input type='checkbox' id='checkSub' name='checkSub'>"+
							 "<td>"+
							 "<input type='text'  style='width:220px;'  id='decode' name='decode'>"+
							 "</td>"+
							 "<td>"+
							 "<input type='text'  style='width:220px;'  id='decodeName' name='decodeName'>"+
							 "</td>"+
							 "<td align='center'>"+
							 "Y<input type='radio'  id='useYN' name='useYN"+count+"' value='Y'>"+
							 "N<input type='radio'  id='useYN' name='useYN"+count+"' value='N'>"+
							 "</td>"+
							 "</tr>"
							 );
					 count--;
				 
				});
			
			$("#update").click(function(){
				$("input[name=I]:checked").each(function(){
					
					$(this).parents('tr').children('td').find("input[name=decodeName]").attr('disabled',false);
					$(this).parents('tr').children('td').find("input[id=useYN]").attr('disabled',false);
					$(this).parents('tr').children('td').find("input[id=checkMain]").attr('name','U');
						
					});

			});
		
			$("#delete").click(function(){
				$("input[name=I]:checked").each(function(){
					$(this).parents('tr').children('td').find("input[name=decode]").attr('style','text-decoration:line-through; color:red;');
					$(this).parents('tr').children('td').find("input[name=decodeName]").attr('style','text-decoration:line-through; color:red;');
					$(this).parents('tr').children('td').find("input[id=checkMain]").attr('name','D');
				});
				
			});
			
			
			
			var flag = false;
			$("#insert2").click(function(){
				flag = false;
				var list = [];
				var count = 10000;
				$("input[type=checkbox]:checked").each(function(){
					var temp = $(this).parents('tr').children('td').find("input[name=decode]").val();
					var temp2 = $(this).parents('tr').children('td').find("input[name=decodeName]").val();
					var temp3 = $(this).parents('tr').children('td').find("input[type=radio]:checked").val();
					var chName = $(this).parents('tr').children('td').find("input[type=checkbox]").attr("name");
					console.log(chName);
					
					var data = {"chName": chName,"code" : $("#code").val(),"decode" : temp ,"decodeName" : temp2
								,"useYN" : temp3	
					}

					
					if(temp.trim() == "" || temp2.trim() == "" || $("td input[type=radio]").is(":checked") == false){
						alert("비어있는 곳이 있습니다.");
						flag = false;
						return false;
						
					}
				
					else{
						count--;
						list.push(data);
						
						flag = true;
					}
					
					
				});
				
				
				for(var i=0;i<list.length;i++){
					for(var j=0;j<list.length;j++){
						if(i!=j){
							if(list[i].decode.trim() == list[j].decode.trim()){
								alert("중복된 값을 입력하셨습니다.");
								flag = false;
								return false;
							}
						}
					}
				}
				
				listAll = JSON.stringify(list);
				
				console.log(list);
				if(flag){
					$.ajax({
						  url: "./commonCodeInsert.ino",
					      type: 'POST',
					      
					      dataType: "json",
					      data: listAll,
					      contentType: "application/json",
					      traditional: true,
					      /* async: false, */
						  success:function(data){
							  console.log(data.res2);
							  if(data.res2 >= 1){
								  alert("중복된 DECODE값입니다.");
								  return false;
							  }else if(data.count == 1){
								  window.close();
							  }		
								  	  
						  },					  
						  error : function(e,errorThrown){						  
						  }   
					});
				}

				});
				
			
			});
			

</script>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<!-- <div style="width:650px;" align="right">
		<a href="/commonCode.ino">리스트로</a>
	</div> -->
	<hr style="width: 600px">

	<form id="frm" name="frm">
		<!-- <div style="width: 150px; float: left;">코드 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name"/></div>

		<div style="width: 150px; float: left;">코드명 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"/></div>

		<div style="width: 150px; float: left;">사용유무(라디오버튼):</div>
		<div style="width: 500px; float: left;" align="left"><input type="radio"> </div>
		<div align="right"> </div>-->
		<input type="hidden" id="code" name="code" value="${ code }">
		<input type="button" value="추가" id="insert">
		<input type="button" value="등록" id="insert2">
		<input type="button" value="수정" id="update">
		<input type="button" value="삭제" id="delete">
		<input type="button" value="다시쓰기" onclick="reset()">
		<input type="button" value="취소" onclick="">
		<hr>
		<table border="1" >
			<col width="25"><col width="230"><col width="230"><col width="100">
			<tr>
				<th>C</th>
				<th>DECODE</th>
				<th>DECODE_NAME</th>
				<th>USE_YN</th>
			</tr>
			
			<c:choose>
				<c:when test="${empty listD}">
				
					<tr>
						<td>없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
		  			<c:forEach var="listD" items="${listD}"  varStatus="status" >
		  				<col width="230"><col width="230"><col width="100">
		  				<tbody>
		  				<tr id="tr">
		  					<td><input type="checkbox" id="checkMain" name="I" ></td>
		  					<td align="center"><input type="text" value="${listD.DECODE }" id="decode" name="decode" disabled></td>
		  					<td align="center"><input type="text" value="${listD.DECODE_NAME }" id="decodeName" name="decodeName" disabled ></td>
		  					
		  					<td align="center">
			  					 Y<input type="radio" id="useYN" name="useYN${status.index }" value="Y" <c:if test="${listD.USE_YN == 'Y'}">checked</c:if> disabled />
			  					 N<input type="radio" id="useYN" name="useYN${status.index }" value="N"<c:if test="${listD.USE_YN == 'N'}">checked</c:if> disabled />
		  					</td>
		  					
		  				</tr>
		  				</tbody>
		  			</c:forEach>
  				</c:otherwise>
			</c:choose>
			<col width="25"><col width="230"><col width="230"><col width="100">
			<tfoot id="tfoot">
			</tfoot>
		</table>
		&nbsp;&nbsp;&nbsp;
	</form>



</body>
</html>