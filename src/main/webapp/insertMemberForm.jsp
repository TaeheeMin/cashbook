<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
	</head>
	
	<body>
		<h3>회원가입</h3>
		<form method="post" action="<%=request.getContextPath()%>/insertMemberAction.jsp">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="text" name="memberPw1"> <br>
						<input type="text" name="memberPw2">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">회원가입</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>