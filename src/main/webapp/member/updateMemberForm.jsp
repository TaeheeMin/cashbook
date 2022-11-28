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
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a>
		</div>
		
		<!-- 개인정보 수정 -->
		<h1>정보 수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp">
			
			<table border="1">
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
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 비밀번호 수정 -->
		<h1>비밀번호 수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<table border="1">
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw" placeholder="현재 비밀번호"> <br>
						<input type="password" name="memberPw1" placeholder="새비밀번호"> <br>
						<input type="password" name="memberPw2" placeholder="비밀번호 확인">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>