<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	// Model : 문의 목록
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(loginMember);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Help List</title>
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
			<table class="table table-bordered">
				<tr>
					<th>문의 내용</th>
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
						<td><%=m.get("helpCreatedate")%></td>
							<%
							if(m.get("commentMemo") != null) {
								%>
									<td><%=m.get("commentMemo")%></td>
									<td><%=m.get("commentCreatedate")%></td>
								<%
							} else {
								%>
									<td>미답변</td>
									<td>미답변</td>
									<td>
										<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>
										<a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
									</td>
								<%
							}
						%>
					</tr>
				<%
				}
				%>
			</table>
		</div>
		
		<div>
			<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
				<table class="table table-bordered">
					<tr>
						<td>문의하기</td>
						<td>
							<textarea rows="5" cols="50" name="helpMemo"></textarea>
						</td>
					</tr>
				</table>
				<div class="position-relative" Style="padding: 1em;">
					<button type="submit"  class="position-absolute top-100 start-50 translate-middle">등록</button>
				</div>
			</form>
		</div>
	</body>
</html>