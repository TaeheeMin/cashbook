<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
		<style>
			body {
				padding: 4.5em;
				background: #f5f5f5
			}
			table {
			 	border: 1px #a39485 solid;
				font-size: .9em;
				box-shadow: 0 2px 5px rgba(0,0,0,.25);
				border-collapse: collapse;
				border-radius: 5px;
				margin-left: auto; 
				margin-right: auto;
				width: 50%;
			}
			a {
				text-decoration: none;
			}
			input {
				width:100%;
			}
			button {
				border: 0;
			}
		</style>
	</head>
	
	<body>
		<div Style="text-align:center;">
			<h3>회원가입</h3>
			<a href="<%=request.getContextPath()%>/loginForm.jsp">홈으로</a>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp">
			<table class="table table-bordered" style="width:50%;">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw1" placeholder="비밀번호""> <br>
						<input type="password" name="memberPw2" placeholder="비밀번호 확인">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName">
					</td>
				</tr>
			</table>
			<div class="position-relative" Style="padding: 1.0em;">
				<button type="submit" class="position-absolute top-100 start-50 translate-middle">회원가입</button>
			</div>
		</form>
	</body>
</html>