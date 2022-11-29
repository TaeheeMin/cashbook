<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	// 1. controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("수정 실패","utf-8");;
	String redirectUrl = "/admin/hlepListAll.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	
	// 2. model
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println(helpNo+"<-helpNo");
	
	Help paramhelp = new Help();
	paramhelp.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help updateHelp = helpDao.helpOne(paramhelp);
	
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.updateOne(commentNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>update comment</title>
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
			textarea {
				border: 0.5px #a39485 solid;
				font-size: .9em;
				outline: none;
				padding-left: 10px;
				width: 100%;
			}
			button {
				border: 0;
			}
		</style>
	</head>
	
	<body>
		<div Style="padding: 4.0em;">
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
				<h3 style="text-align:center;">문의</h3>
				<table class="table table-bordered">
					<tr>
						<td style="width:100px;">작성자</td>
						<td>
							<%=updateHelp.getMemberId()%>
						</td>
					</tr>
					<tr>
						<td style="width:100px;">내용</td>
						<td>
							<%=updateHelp.getHelpMemo() %>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 입력폼 -->
			<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
				<input type="hidden" value="<%=comment.getCommentNo()%>" name="commentNo">
				<input type="hidden" value="<%=comment.getCommentNo()%>" name="commentNo">
				<table class="table table-bordered">
					<tr>
						<td style="text-align:center;">답변수정</td>
						<td>
							<textarea rows="5" cols="150" name="commentMemo"><%=comment.getCommentMemo() %></textarea>
						</td>
					</tr>
				</table>
				<div class="position-relative">
				    <button type="submit" class="position-absolute top-100 start-50 translate-middle">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>