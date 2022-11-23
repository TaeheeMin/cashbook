<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println("로그인중");
		return;
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Form</title>
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
		<h1>로그인</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table>
				<tr>
					<td>id</td>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<td>pw</td>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
			</table>
			<button type="submit">로그인</button>
		</form>
		<div >
			<button type="button" onclick="location.href='<%=request.getContextPath()%>/insertMemberForm.jsp'">회원가입</button>
		</div>
	</body>
</html>