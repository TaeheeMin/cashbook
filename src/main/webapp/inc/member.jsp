<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<sidebar>
	<div class="logo">CASHBOOK</div>
		<div class="avatar">
	  		<div class="avatar__img">
	    		<img src="<%=request.getContextPath()%>/img/profile.png" alt="avatar" style="width:50px;">
 		</div>
 		
 		<div class="avatar__name"><%=loginMember.getMemberName() %></div>
  	</div>
	  	
	<nav class="menu">
		<a class="menu__item" href="<%=request.getContextPath()%>/cash/cashMain.jsp">
			<i class="menu__icon fa fa-home"></i>
			<span class="menu__text">홈</span>
		</a>
		<a class="menu__item menu__item--active" href="<%=request.getContextPath()%>/cash/cashList.jsp">
			<i class="menu__icon fa fa-calendar"></i>
			<span class="menu__text">calendar</span>
		</a>
		<a class="menu__item" href="<%=request.getContextPath()%>/help/helpList.jsp">
			<i class="menu__icon fa fa-envelope"></i>
			<span class="menu__text">고객센터</span>
		</a>
		<a class="menu__item" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">
		    <i class="menu__icon fa fa-sliders"></i>
		    <span class="menu__text">my profile</span>
		</a>
		<a class="menu__item" href="#">
			<i class="menu__icon fa fa-list"></i>
			<span class="menu__text">미정</span>
		</a>
		<a class="menu__item" href="#">
			<i class="menu__icon fa fa-bar-chart"></i>
			<span class="menu__text">미정</span>
		</a>
		<a class="menu__item" href="<%=request.getContextPath()%>/logout.jsp">
			<i class="menu__icon fa fa-trophy"></i>
			<span class="menu__text">logout</span>
		</a>
	</nav>
</sidebar>