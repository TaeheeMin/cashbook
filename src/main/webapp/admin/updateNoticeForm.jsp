<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 공지 내용 하나 가져와서 내용 보여주고 수정
	// 공지 번호가져와서 select -> notice로 받아와서 출력 -> memo만 수정가능하게 
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	//Notice notice = new Notice();
	//notice.setNoticeNo(noticeNo);
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateNoticeForm</title>
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
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/adminMain.jsp">관리자 페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=1">공지관리</a></li> <!-- notice 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li> <!-- category 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">회원관리</a></li>
			<li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
		</ul>
		<h1>공지 수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp">
			<table border="1">
				<tr>
					<td>내용</td>
					<td>
					<textarea rows="5" cols="150" ></textarea>
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
