<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
 <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script type="text/javascript">
 
 // 1. 정규식 > 공백정규식 regText.replace(/ /gi, "");    // 모든 공백을 제거
 // 2. .trim();
 	$(function(){
 		$("#btn").click(function(){
 			var name = $("#name").val().replace(/ /gi, "");
 			var title = $("#title").val().trim();
 			var content = $("#content").val().trim();
 			
 			console.log(title+name.trim());
 			if(name == ""){
 				alert("name write please");
 				return false;
 			}
 			
 			
 			if(title == ""){
 				alert("title write please");
 				return false;
 			}
 			
 			if(content == ""){
 				alert("content write please");
 				return false;
 			}
 			
		var frm = $("#submitForm").serialize();
 			
 			$.ajax({
 				url:"./freeBoardInsertPro.ino",
 				data:frm,
 				type:"POST",
 				dataType:"json",
 				success:function(data){
 					if(data.res > 0){
 						location.href="/main.ino"
 						//location으로 가는 것은 URL을 기준으로 가기 때문에
 					}
 				},
 				error : function(e,errorThrown){
 					
 				}
 			});
 			
 		})
 		

 			

 	});
 	
 	
 		

 	
 	
 </script>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action="./freeBoardInsertPro.ino" method="POST" id="submitForm">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType" id="searchType" >
							<c:forEach var="nWoe" items="${listT }">
								<option value="${nWoe.DECODE }">${nWoe.DECODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" id="btn">
					<input type="reset" value="다시쓰기" >
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>