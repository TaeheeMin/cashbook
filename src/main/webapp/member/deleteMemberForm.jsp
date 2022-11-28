<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>delete member</title>
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
		<div>
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		</div>
		
		<h1 Style="text-align:center;">회원탈퇴</h1>
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<table class="table table-bordered" style="width:50%;">
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
			</table>
			<div class="position-relative" Style="padding: 1.0em;">
				<button type="submit" class="position-absolute top-100 start-50 translate-middle">DELETE</button>
			</div>
		</form>
	</body>
</html>