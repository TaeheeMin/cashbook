<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 1.controller
	// controller : session 검증
	Member loginMember = (Member)session.getAttribute("loginMember");
	String msg = URLEncoder.encode("삭제 실패","utf-8");;
	String redirectUrl = "/admin/noticeList.jsp?msg=";
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	}
	
	// 2. model
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo+"<-helpNo");
	
	Help paramhelp = new Help();
	paramhelp.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help insertComment = helpDao.helpOne(paramhelp);

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert comment</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	    <!-- Libraries Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath()%>/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">
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
   			<!-- Navbar -->
   			<jsp:include page="/inc/adminNav.jsp"></jsp:include>
   			<!-- 문의내용 -->
			<div class="container-fluid pt-4 px-4">
                <div class="text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">문의 내용</h6>
                    </div>
                   <div class="table-responsive">
	                    <table class="table">
                            <thead>
                                <tr class="text-dark">
									<td>작성자</td>
									<td>내용</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><%=insertComment.getMemberId()%></td>
									<td><%=insertComment.getHelpMemo() %></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- 입력폼 -->
			<div class="container-fluid">
				<div class="row h-100 align-items-center justify-content-center" style="min-height: 30vh;">
					<div class="col-12 col-xl-6">
						<div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
	                    	<h6 class="mb-4">답변등록</h6>
		                 	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
		                     	<input type="hidden" value="<%=insertComment.getHelpNo()%>" name="helpNo">
		                     	<div class="row mb-3">
			                         <div class="form-floating">
	                                	<textarea class="form-control" placeholder="Leave a comment here" style="height: 150px;" name="commentMemo"></textarea>
	                                	<label for="floatingTextarea">Comments</label>
	                           		</div>
		                     	</div>
	                     		<button type="submit" class="btn btn-primary">추가</button>
	                 		</form>
                       </div>
	                </div>
	            </div>
	        </div>
	        <!-- 입력폼 -->
		</div>
	</body>
</html>