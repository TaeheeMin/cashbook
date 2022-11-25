<%@page import="javax.print.attribute.standard.NumberOfDocuments"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>

<%
	// 1.controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	String rdirectUrl = "/admin/adminMain.jsp";
	String msg = URLEncoder.encode("관리자 페이지입니다.","utf-8");
	
	// 로그인 세션 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("로그인 필요.","utf-8");
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
	
	// 2. model : notice List
	NoticeDao noticeDao = new NoticeDao();
	// 페이징 알고리즘
	ArrayList<Notice> list = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	
	int noticeCount = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)noticeCount / (double)rowPerPage);
	System.out.println(noticeCount + "<-noticeCount/" + lastPage + "lastPage" );
	

	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList</title>
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
			<!-- adbmin 컨텐츠 내용 -->
			<h1>공지</h1>
			<div>
				<table border="1">
					<tr>
						<th>번호</th>
						<th>공지내용</th>
						<th>작성일</th>
						<th>수정삭제</th>
					</tr>
					<%
						for(Notice n : list){
						%>
							<tr>
								<td><%=n.getNoticeNo()%></td>
								<td><%=n.getNoticeMemo() %></td>
								<td><%=n.getCreatedate() %></td>
								<td>
									<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
									<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp">수정</a>
									<a href="<%=request.getContextPath()%>/admin/deleteNoticeForm.jsp">삭제</a>
								</td>
							</tr>
						<%
						}
					%>
				</table>
				
				<!-- 페이징 -->
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
			
			<div>
			<!-- 입력폼 -->
			<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
				<table border="1">
					<tr>
						<td>공지내용</td>
						<td>
							<textarea rows="5" cols="150" name="noticeMemo"></textarea>
						</td>
					</tr>
					<tr>
					<td colspan="2"><button type="submit">등록</button></td>
					</tr>
				</table>
			</form>
			</div>
			
	</body>
</html>