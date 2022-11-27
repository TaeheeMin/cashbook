<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println(cashNo+"<-cashNo");
	
	// controller : session 검증
	// 로그인 세션 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null ){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	// 삭제시 비밀번호 작성 후 action으로 보내줌
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>delete cash form</title>
	</head>
	
	<body>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
			<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">내정보수정</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
		<form action="<%=request.getContextPath()%>/cash/deleteCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
			<input type="hidden" name="cashNo" value="<%=cashNo %>">
			<table>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
				<tr>
					<td colspan ="2">
						<button type="submit">DELETE</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>