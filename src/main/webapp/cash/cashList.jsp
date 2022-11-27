<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
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
	// request -> 년도 + 월
	int year = 0;
	int month = 0;
	// 오늘 년도구하는 알고리즘
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -1, 12인 경우 보정
		if(month == -1) {
			month = 11;
			year--;
		}
		if(month == 12) {
			month = 0;
			year++;
		}
	}
	
	// 출력하고자 하는 년, 월과 1일 요일구하는 알고리즠
	// 일=1 월=2 화=3...
	Calendar targetDate = Calendar.getInstance();
	// 지금으로 셋
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// 마지막 날짜구하는 알고리즘
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	// 출력테이블의 시작 공백셀 마지막 공백셀 구하는 알고리즘
	int beginBlank = firstDay -1;
	int endBlank = 0; // (beginBlank + lastDate + endBlank) -> 7로 나누어 떨어짐
	if((beginBlank + lastDate)% 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate)% 7);
	}
	// 전체 td개수 = 7로 나누어 떨어짐
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model : 일별 cash목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	// view : 달력 출력+ 일별 csah 목록
	// 날짜 클릭 수입지출 내역 확인 기능
	// 수입 지출 입력 기능
	// 
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cash List</title>
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
		<div>
			<!-- 로그인 정보(세션 loginMember 변수이름으로 정보) 출력 -->
			<h1><%=loginMember.getMemberId() %>님 반갑습니다.</h1>
			<%
				if(loginMember.getMemberLevel() > 0) {
					%>
						<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
					<%
				}
			%>

		</div>
		
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
			
			<%=year%>년 <%=month+1%> 월
			
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
			<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">내정보수정</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
		
		<div>
			<table border="1" width="80%">
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
				<tr>
					<% 
					for(int i = 1; i <= totalTd; i++) {
					%>
						<td>
							<%
							int date = i - beginBlank;
							if(date > 0 && date <= lastDate) {
							%>
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&day=<%=date%>">
										<%=date%>
									</a>
								</div>
								<div>
									<%
										//날짜별 수입지출
										for(HashMap<String, Object> m : list){
											String cashDate = (String)m.get("cashDate");
											if(Integer.parseInt(cashDate.substring(8)) == date) {
									%>
												<div>
													[<%=(String)m.get("categoryKind")%>]
													<%=(String)m.get("categoryName")%>
													&nbsp;
													<%=(Integer)m.get("cashPrice")%>원
												</div>
									<%
											}
										}
									%>
								</div>
							<%
							}
							%>
						</td>
						<%
						if(i%7 == 0 && i != totalTd) { // td7개마다 tr끊어줌
						%>
							</tr><tr>
						<%		
						}
					}
					%>
			</table>
		</div>
	</body>
</html>