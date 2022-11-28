<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<title>update member</title>
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
			}
			a {
				text-decoration : none;
			}
			button {
				border: 0;
			}
			input {
				width: 100%;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		</div>
		
		<!-- 개인정보 수정 -->
		<div>
			<h1 Style="text-align:center;">정보 수정</h1>
			<form method="post" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw" placeholder="비밀번호 확인">
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>">
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit"  class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
			</form>
		</div>
		
		<!-- 비밀번호 수정 -->
		<div Style="padding: 2.0em;">
			<h1 Style="text-align:center;" >비밀번호 수정</h1>
			<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw" placeholder="현재 비밀번호"> <br>
							<input type="password" name="memberPw1" placeholder="새비밀번호"> <br>
							<input type="password" name="memberPw2" placeholder="비밀번호 확인">
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit"  class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
			</form>
		</div>
		<div class="position-relative" Style="padding: 1.0em;">
			<button type="button" class="position-absolute top-100 start-50 translate-middle" onclick="location.href='<%=request.getContextPath()%>/member/deleteMemberForm.jsp'">회원탈퇴</button>
		</div>
	</body>
</html>