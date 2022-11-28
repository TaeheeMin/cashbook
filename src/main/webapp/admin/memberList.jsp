<%@ page import = "java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
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
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// model 호출
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

		<!-- 회원관리(목록, 레벨수정, 강제탈퇴)  -->
		<h1 Style="text-align:center;">회원 목록</h1>
		<div>
			<table class="table table-bordered">
				<tr Style="text-align:center;">
					<th>NO</th>
					<th>ID</th>
					<th>LEVEL</th>
					<th>NAME</th>
					<th>CREATEDATE</th>
					<th>UPDATE DATE</th>
					<th>ACTION</th>
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
								<a href="<%=request.getContextPath()%>/admin/updateMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">삭제</a>
							</td>
						</tr>
						<%
					}
				%>
			</table>
			
		</div>
		<div Style="text-align:center;">
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