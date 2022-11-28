<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg="+msg;
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}

	// 2. model
	// 최근 공지 5개, 최근멤버 5명 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 회원 페이징
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemverListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount();
	int memberLastPage = (int)Math.ceil((double)memberCount / (double)rowPerPage);
	System.out.println(memberCount + "<-memberCount/" + memberLastPage + "lastPage"+ rowPerPage);
	
	// 공지 페이징
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	int noticeCount = noticeDao.selectNoticeCount();
	int noticeLastPage = (int)Math.ceil((double)noticeCount / (double)rowPerPage);
	System.out.println(noticeCount + "<-noticeCount/" + noticeLastPage + "lastPage" );
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 페이지</title>
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
		<h1>관리자 페이지</h1>
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=1">공지관리</a></li> <!-- notice 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li> <!-- category 메서드 사용 -->
			<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">회원관리</a></li>
			<li><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></li>
		</ul>
		<div>
			<!-- adbmin 컨텐츠 내용 -->
			<!-- 3가지 목록 모두 CRUD 필요+ 페이징 -->
			<!-- noticeDao -> CRUD  카테고리 ->  페이징X -->
			<h2>공지</h2>
			<table border="1">
				<tr>
					<th>번호</th>
					<th>공지내용</th>
					<th>작성일</th>
				</tr>
				<%
					for(Notice n : noticeList){
					%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo() %></td>
							<td><%=n.getCreatedate() %></td>
						</tr>
					<%
					}
				%>
			</table>
			
			<h2>회원</h2>
			
			<table border="1">
				<tr>
					<th>NO</th>
					<th>ID</th>
					<th>LEVEL</th>
					<th>NAME</th>
					<th>CREATEDATE</th>
					<th>UPDATE DATE</th>
				</tr>
				<%
					for(Member m : memberList) {
						%>
						<tr>
							<td><%=m.getMemberNo() %></td>
							<td><%=m.getMemberId() %></td>
							<td><%=m.getMemberLevel() %></td>
							<td><%=m.getMemberName() %></td>
							<td><%=m.getCreatedate() %></td>
							<td><%=m.getUpdatedate() %></td>
						</tr>
						<%
					}
				%>
			</table>
		</div>
	</body>
</html>