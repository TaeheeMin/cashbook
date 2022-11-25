<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-noticeNo");
	
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
	// 어 근데 비밀번호는 없는데? 비밀번호를 조인해서 가져와야 하는건가????
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice delete forms</title>
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
		<h1>공지 삭제</h1>
		
		<form action="<%=request.getContextPath()%>/admin/deleteNoticeAction..jsp" method="post">
			<table>
				<tr>
				 <th>비밀번호</th>
				 <td><input type="password" name=""></td>
				</tr>
			</table>
		
		</form>
	</body>
</html>