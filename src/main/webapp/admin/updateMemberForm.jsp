<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/memberList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	// 2. model
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	Member memberOne = memberDao.memberOneByAdmin(memberNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm</title>
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
		<h1>회원 정보 수정</h1>
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/adminMain.jsp">관리자 페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp">공지관리</a></li> <!-- notice 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li> <!-- category 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">회원관리</a></li>
			<li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
		</ul>
		<form method="post" action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp">
			<input type="hidden" name="memberNo" value="<%=memberOne.getMemberNo()%>">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" readonly="readonly" value="<%=memberOne.getMemberId()%>">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName" value="<%=memberOne.getMemberName()%>">
					</td>
				</tr>
				<tr>
					<td>회원 레벨</td>
					<td>
					<%
						if(memberOne.getMemberLevel() == 0) {
							%>
							<input type="radio" name="memberLevel" value="0" checked>일반
							<input type="radio" name="memberLevel" value="1">관리자
							<%
						} else {
							%>
							<input type="radio" name="memberLevel" value="0">일반
							<input type="radio" name="memberLevel" value="1" checked>관리자
							<%
						}
					%>
					</td>
					
				</tr>
				<tr>
					<td colspan="2"><button type="submit">수정</button></td>
				</tr>
			</table>
		</form>
	</body>
</html>