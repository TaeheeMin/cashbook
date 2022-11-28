<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark  fixed-top">
  			<div class="container-fluid">
    			<a class="navbar-brand" href="javascript:void(0)">CashBook</a>
    			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
     				<span class="navbar-toggler-icon"></span>
   				</button>
    			<div class="collapse navbar-collapse" id="mynavbar">
      				<ul class="navbar-nav me-auto">
        				<li class="nav-item">
          					<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">달력보기</a>
        				</li>
        				<li class="nav-item">
         					 <a class="nav-link" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">정보수정</a>
        				</li>
        				<li class="nav-item">
          					<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
        				</li>
      				</ul>
      				<form class="d-flex">
      					<a class="navbar-brand" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">
					    	<%=loginMember.getMemberId() %>님&nbsp;<img src="<%=request.getContextPath()%>/img/profile.png" style="width:30px; " class="rounded-pill ">
					    </a>
      				</form>
    			</div>
 			</div>
		</nav>
	</body>
</html>