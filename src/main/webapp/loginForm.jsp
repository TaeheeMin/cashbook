<%@page import="javax.print.attribute.standard.NumberOfDocuments"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println("로그인중");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	
	int count = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage); // 구하기
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Form</title>
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
			}
			button {
				border: 0;
			}
			input {
				width:100%;
			}
		</style>
	</head>
	
	<body>
		<h1 Style="text-align:center;">공지</h1>
		<!-- 공지5개목록 페이징 -> 수정 삭제는 관리자 페이지에서 그냥 읽기만 가능-->
		<div>
		<table class="table table-bordered">
			<tr Style="text-align:center;">
				<th>공지</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list){
					%>
					<tr>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate() %></td>
					</tr>
					<%
				}
			%>
			</table>
			<div Style="text-align:center;">
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
		
		<div Style="text-align:center; padding: 1.0em;">
			<h1>로그인</h1>
			
			<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
				<table class="table table-bordered" style="width:50%;">
					<tr>
						<td>id</td>
						<td>
							<input type="text" name="memberId">
						</td>
					</tr>
					<tr>
						<td>pw</td>
						<td>
							<input type="password" name="memberPw">
						</td>
					</tr>
				</table>
				<button type="submit">로그인</button>
			</form>
		</div>
		<div class="position-relative" Style="text-align:center; padding: 0.5em;">
			<button type="button" class="position-absolute top-100 start-50 translate-middle" onclick="location.href='<%=request.getContextPath()%>/member/insertMemberForm.jsp'">회원가입</button>
		</div>
	</body>
</html>