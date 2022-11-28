<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println(cashNo+"<-cashNo");
	
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
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>delete cash form</title>
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
			input {
				width: 100%;
			}
		</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		</div>
		
		<div>
			<form action="<%=request.getContextPath()%>/cash/deleteCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
				<input type="hidden" name="cashNo" value="<%=cashNo %>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="memberPw">
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit" class="position-absolute top-100 start-50 translate-middle">DELETE</button>
				</div>
			</form>
		</div>
	</body>
</html>