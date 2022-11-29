<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
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
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	int count = helpDao.selectHelpCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage);
	System.out.println(count + "<-count/" + lastPage + "lastPage" );
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>help List All</title>
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
				padding: 3.5em;
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
				width: 80%;
			}
			a {
				text-decoration: none;
			}
			button {
				border: 0;
			}
			textarea {
				width: 100%;
			}
		</style>
	</head>
	
	<body>
		<div>
			<%
				if(loginMember.getMemberLevel() > 0) {
					%>
						<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
					<%
				} else {
					%>
						<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
					<%
				}
			%>
		</div>
		
		<div>
			<table class="table table-bordered">
				<tr>
					<th>문의 내용</th>
					<th>회원ID</th>
					<th>작성일</th>
					<th>답변</th>
					<th>답변 작성일</th>
					<th>수정삭제</th>
				</tr>
				<%
				for(HashMap<String, Object> m : list){
				%>
					<tr>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<%
							if(m.get("commentMemo") != null) {
							%>
								<td><%=m.get("commentMemo")%></td>
								<td><%=m.get("commentCreatedate")%></td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>">답변수정</a>
									<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>"">답변삭제</a>
								</td>
							<%
							} else {
							%>
								<td> </td>
								<td> </td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변등록</a>
								</td>
							<%
							}
							%>
					</tr>
					<%
					}
					%>
			</table>
			<div style="text-align:center;">
				<!-- 페이징 -->
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
			</div>
		</div>
	</body>
</html>