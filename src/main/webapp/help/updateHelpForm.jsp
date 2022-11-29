<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	// 1. controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	// 2. model
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo+"<-helpNo");
	
	Help paramhelp = new Help();
	paramhelp.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help updateHelp = helpDao.helpOne(paramhelp);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Update Help Form</title>
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
			td {
				height: 150px;
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
			<form method="post" action="<%=request.getContextPath()%>/help/updateHelpAction.jsp">
				<input type="hidden" value="<%=updateHelp.getHelpNo()%>" name="helpNo">
				<table class="table table-bordered">
					<tr>
						<td>내용</td>
						<td>
						<textarea rows="5" cols="150" name="helpMemo"><%=updateHelp.getHelpMemo() %></textarea>
						</td>
					</tr>
				</table>
				<button type="submit" >수정</button>
			</form>
		</div>
	</body>
</html>