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
	String redirectUrl = "/admin/noticeList.jsp?msg="+msg;
	
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		msg = URLEncoder.encode("관리자 권한 필요","utf-8");
		redirectUrl= "/loginForm.jsp?msg="+msg;
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	// 2. model
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	
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
			
			 	<!-- 카테고리 추가 Start -->
           	<div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 30vh;">
	                <div class="col-12 col-xl-6">
	                       <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
	                       <h6 class="mb-4">카테고리 추가</h6>
		                 <form method ="post" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" >
		                     <div class="row mb-3">
		                         <label for="inputEmail3" class="col-sm-2 col-form-label">Name</label>
		                         <div class="col-sm-10">
		                             <input class="form-control mb-3" type="text" name="categoryName">
		                         </div>
		                     </div>
		                     <fieldset class="row mb-3">
		                         <legend class="col-form-label col-sm-2 pt-0">category Kind</legend>
		                         <div class="col-sm-10">
		                             <div class="form-check">
		                                 <input class="form-check-input" type="radio" name="categoryKind" value="수입">
		                                 <label class="form-check-label" for="gridRadios1">
		                                     수입
		                                 </label>
		                             </div>
		                             <div class="form-check">
		                                 <input class="form-check-input" type="radio" name="categoryKind" value="지출">
		                                 <label class="form-check-label" for="gridRadios2">
		                                 	지출
		                                 </label>
		                             </div>
		                         </div>
		                     </fieldset>
	                     <button type="submit" class="btn btn-primary">추가</button>
		                 </form>
	                       </div>
	                </div>
	            </div>
	        </div>
           	<!-- 카테고리 추가 End -->
			
			<!-- 카테고리 목록 Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Category List</h6>
                    </div>
                   <div class="table-responsive">
	                    <table class="table">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">번호</th>
                                    <th scope="col">종류</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">수정일</th>
                                    <th scope="col">생성일</th>
                                    <th scope="col">ACTION</th>
                                </tr>
                            </thead>
                            <tbody>
	                            <%
	                            for(Category c : categoryList) {
								%>
									<tr>
										<td><%=c.getCategoryNo() %></td>
										<td><%=c.getCategoryKind() %></td>
										<td><%=c.getCategoryName() %></td>
										<td><%=c.getUpdatedate() %></td>
										<td><%=c.getUpdatedate() %></td>
										<td>
											<a class="btn btn-sm btn-primary" href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
											<a class="btn btn-sm btn-primary" href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
										</td>
									</tr>
								<%
								}
								%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
           	<!-- 카테고리 목록 End -->
           	
		</div>
	</body>
</html>