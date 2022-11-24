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
	// 정보 수정 누르면 아이디 받아와서 비밀번호 확인, 이름 수정
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
		<h1>내 정보 수정</h1>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
			<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">내정보수정</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/updateMemberAction.jsp">
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
						<input type="password" name="memberPw">
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
	</body>
</html>