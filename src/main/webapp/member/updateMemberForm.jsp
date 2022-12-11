<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>update member</title>
		<link  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/NewFile.css">
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
 		<!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">
	
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
	<%
			if(loginMember.getMemberLevel() > 0) {
		%>
					<div>
						<!-- Sidebar -->
						<jsp:include page="/inc/adminSideMenu.jsp"></jsp:include>
					</div>
		<%
			} else {
		%>
					<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
		<%
			}
		%>
		
   		<div class="content">
   			<main>
		<!-- 개인정보 수정 -->
		<div>
			<h1 Style="text-align:center;">정보 수정</h1>
			<form method="post" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="memberId" readonly="readonly" value="<%=loginMember.getMemberId()%>">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw" placeholder="비밀번호 확인">
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>">
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit"  class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
			</form>
		</div>
		
		<!-- 비밀번호 수정 -->
		<div Style="padding: 2.0em;">
			<h1 Style="text-align:center;" >비밀번호 수정</h1>
			<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<table class="table table-bordered" Style="width:50%;">
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw" placeholder="현재 비밀번호"> <br>
							<input type="password" name="memberPw1" placeholder="새비밀번호"> <br>
							<input type="password" name="memberPw2" placeholder="비밀번호 확인">
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1.0em;">
					<button type="submit"  class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
			</form>
		</div>
		<div class="position-relative" Style="padding: 1.0em;">
			<button type="button" class="position-absolute top-100 start-50 translate-middle" onclick="location.href='<%=request.getContextPath()%>/member/deleteMemberForm.jsp'">회원탈퇴</button>
		</div>
		</main>
		</div>
	</body>
</html>