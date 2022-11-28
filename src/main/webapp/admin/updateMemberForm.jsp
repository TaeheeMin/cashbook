<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	//1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/memberList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	// 2. model
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	Member memberOne = memberDao.memberOneByAdmin(memberNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm</title>
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
			a {
				text-decoration : none;
			}
			button {
				border: 0;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div>
		
		<div>
			<h3 Style="text-align:center;">회원 수정</h3>
			<form method="post" action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp">
				<input type="hidden" name="memberNo" value="<%=memberOne.getMemberNo()%>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<td Style="text-align:center;">아이디</td>
						<td>
							<input type="text" name="memberId" readonly="readonly" value="<%=memberOne.getMemberId()%>" style="width: 100%;">
						</td>
					</tr>
					<tr>
						<td Style="text-align:center;">이름</td>
						<td>
							<input type="text" name="memberName" value="<%=memberOne.getMemberName()%>" style="width: 100%;">
						</td>
					</tr>
					<tr>
						<td Style="text-align:center;">회원 레벨</td>
						<td>
						<%
							if(memberOne.getMemberLevel() == 0) {
								%>
								<input type="radio" name="memberLevel" value="0" checked>일반
								<input type="radio" name="memberLevel" value="1">관리자
								<%
							} else {
								%>
								<input type="radio" name="memberLevel" value="0">일반
								<input type="radio" name="memberLevel" value="1" checked>관리자
								<%
							}
						%>
						</td>
						
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit" class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
				
			</form>
		</div>
	</body>
</html>