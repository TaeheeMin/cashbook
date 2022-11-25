<%@ page import = "java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	String rdirectUrl = "/admin/adminMain.jsp";
	String msg = URLEncoder.encode("관리자 페이지입니다.","utf-8");
	
	// 로그인 세션 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		rdirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+rdirectUrl);
		return;
	}
	// 페이징 알고리즘
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 2. model
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemverListByPage(beginRow, rowPerPage);
	
	int memberCount = memberDao.selectMemberCount();
	int lastPage = (int)Math.ceil((double)memberCount / (double)rowPerPage);
	System.out.println(memberCount + "<-noticeCount/" + lastPage + "lastPage" );
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberList</title>
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
			<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp">공지관리</a></li> <!-- notice 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li> <!-- category 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">회원관리</a></li>
			<li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
		</ul>

		<!-- adbmin 컨텐츠 내용 -->
		<!-- 회원관리(목록, 레벨수정, 강제탈퇴)  -->
		<h1>회원 목록</h1>
		<div>
			<table border="1">
				<tr>
					<th>NO</th>
					<th>ID</th>
					<th>LEVEL</th>
					<th>NAME</th>
					<th>CREATEDATE</th>
					<th>UPDATE DATE</th>
					<th>UPDATE</th>
					<th>DELETE</th>
				</tr>
				<%
					for(Member m : list) {
						%>
						<tr>
							<td><%=m.getMemberNo() %></td>
							<td><%=m.getMemberId() %></td>
							<td><%=m.getMemberLevel() %></td>
							<td><%=m.getMemberName() %></td>
							<td><%=m.getCreatedate() %></td>
							<td><%=m.getUpdatedate() %></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/updateMemberForm.jsp">수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/deleteMemberForm.jsp">삭제</a>
							</td>
						</tr>
						<%
					}
				%>
			</table>
			
			<!-- 페이징 -->
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1){
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
		

	</body>
</html>