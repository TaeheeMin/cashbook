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
				width: 50%;
			}
			a {
				text-decoration: none;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
		<div>
			<h3 Style="text-align:center;">공지</h3>
			<table class="table table-bordered">
				<tr Style="text-align:center;">
					<th style="width:100px;">번호</th>
					<th>공지내용</th>
					<th style="width:200px;">작성일</th>
				</tr>
				<%
					for(Notice n : noticeList){
					%>
						<tr>
							<td Style="text-align:center;"><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo() %></td>
							<td><%=n.getCreatedate() %></td>
						</tr>
					<%
					}
				%>
			</table>
		</div>
		<div Style="text-align:center;">
			<h3>회원목록</h3>
			<table class="table table-bordered">
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