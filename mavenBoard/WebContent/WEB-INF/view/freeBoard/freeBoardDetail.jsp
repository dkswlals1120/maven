<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			var frm = $("#frm").serialize();
			
			$.ajax({
 				url:"./freeBoardModify.ino",
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
		
		$("#delete").click(function(){
			var frm = $("#frm").serialize();
			
			$.ajax({
 				url:"./freeBoardDelete.ino",
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
	})
	
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

	<!--  <form name="insertForm">-->
	<form action="./freeBoardModify.ino" method="POST" id="frm">
		<input type="hidden" name="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType">
							<option value="01" <c:if test="${freeBoardDto.codeType eq '01'}" >selected</c:if>>자유</option>
							<option value="02" <c:if test="${freeBoardDto.codeType eq '02'}" >selected</c:if>>익명</option>
							<option value="03" <c:if test="${freeBoardDto.codeType eq '03'}" >selected</c:if>>QnA</option>
						</select>
						
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" id="btn" >
					<input type="button" value="삭제" id="delete" >
					<!--onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'"  -->
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>