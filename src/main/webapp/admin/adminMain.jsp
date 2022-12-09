<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
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
	// 최근 문의 5개, 공지 5개, 회원 5명 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 문의
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	int count = helpDao.selectHelpCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage);
	
	// 회원
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemverListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount();
	int memberLastPage = (int)Math.ceil((double)memberCount / (double)rowPerPage);
	System.out.println(memberCount + "<-memberCount/" + memberLastPage + "lastPage"+ rowPerPage);
	
	// 공지
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	int noticeCount = noticeDao.selectNoticeCount();
	int noticeLastPage = (int)Math.ceil((double)noticeCount / (double)rowPerPage);
	System.out.println(noticeCount + "<-noticeCount/" + noticeLastPage + "lastPage" );
	
	// 3.view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <title>관리자 페이지</title>
	    <meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	    
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
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
			
			<!-- 최근 문의 Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
			      		<h6 class="mb-0">문의목록</h6>
			        	<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Show All</a>
					</div>
                    
                    <div class="table-responsive">
                   		<table class="table text-start align-middle table-bordered table-hover mb-0">
                        	<thead>
                            	<tr class="text-dark">
	                                <th scope="col">NO</th>
	                                <th scope="col">문의내용</th>
	                                <th scope="col">회원ID</th>
	                                <th scope="col">작성일</th>
	                                <th scope="col">답변</th>
	                            </tr>
                   			</thead>
                           
                           	<tbody>
		                        <%
		                        for(HashMap<String, Object> m : list){
								%>
									<tr>
										<td><%=m.get("helpNo")%></td>
										<td><%=m.get("helpMemo")%></td>
										<td><%=m.get("memberId")%></td>
										<td><%=m.get("helpCreatedate")%></td>
										<%
										if(m.get("commentMemo") != null) {
										%>
												<td>신규</td>
											<%
										} else {
											%>
												<td>답변 완료</td>
										<%
										}
										%>
									</tr>
									<%
									}
									%>
                            </tbody>
						</table>
					</div>
				</div>
			</div>
            <!-- 최근 문의 End -->
			
			<!-- 공지 5개 Start -->
			<div class="container-fluid pt-4 px-4">
    			<div class="text-center rounded p-4">
        			<div class="d-flex align-items-center justify-content-between mb-4">
            			<h6 class="mb-0">공지</h6>
            			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Show All</a>
					</div>

					<div class="table-responsive">
    					<table class="table text-start align-middle table-bordered table-hover mb-0">
        					<thead>
					            <tr class="text-dark">
					                <th Style="text-align:center;" scope="col">NO</th>
							        <th scope="col">NOTICE</th>
							        <th scope="col">CREATE DATE</th>
					    		</tr>
							</thead>

							<tbody>
								<%
									for(Notice n : noticeList){
								%>
										<tr>
											<td Style="text-align:center;"><%=n.getNoticeNo()%></td>
											<td><%=n.getNoticeMemo() %></td>
											<td><%=n.getCreatedate() %></td>
										</tr>
								<%
									}
								%>
                			</tbody>
            			</table>
        			</div>
    			</div>
			</div>
			<!-- 공지 5개 End -->
            
            <!-- 최근가입 회원 Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
			      		<h6 class="mb-0">회원목록</h6>
			        	<a href="<%=request.getContextPath()%>/admin/memberList.jsp">Show All</a>
					</div>
                    
                    <div class="table-responsive">
                   		<table class="table text-start align-middle table-bordered table-hover mb-0">
                        	<thead>
                            	<tr class="text-dark">
	                                <th scope="col">NO</th>
	                                <th scope="col">ID</th>
	                                <th scope="col">LEVEL</th>
	                                <th scope="col">NAME</th>
	                                <th scope="col">CREATE DATE</th>
	                                <th scope="col">UPDATE DATE</th>
	                            </tr>
                   			</thead>
                           
                           	<tbody>
		                        <%
									for(Member m : memberList) {
								%>
									<tr>
										<td><%=m.getMemberNo() %></td>
										<td><%=m.getMemberId() %></td>
										<td><%=m.getMemberLevel() %></td>
										<td><%=m.getMemberName() %></td>
										<td><%=m.getCreatedate() %></td>
										<td><%=m.getUpdatedate() %></td>
									</tr>
								<%
									}
								%>
                            </tbody>
						</table>
					</div>
				</div>
			</div>
            <!-- 최근가입 회원 End -->
		</div>	
	</body>
</html>