<%@page import="vo.Cash"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// controller : session 검증
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
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);
	
	// view : 달력 출력+ 일별 csah 목록
	// 날짜 클릭 수입지출 내역 확인 기능
	// 수입 지출 입력 기능

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cash List</title>
	</head>
	
	<body>
		<div>
			<!-- 로그인 정보(세션 loginMember 변수이름으로 정보) 출력 -->
			<table>
			
			</table>
		</div>
		
		<div>
			<%=year %>년 <%=month +1%> 월
		</div>
		<div>
			<table border="1">
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>굼</th>
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
								<%=date%>
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
		<div>
			<table border="1">
				<tr>
					<th>cashNo</th>
					<th>cashDate</th>
					<th>cashPrice</th>
					<th>categoryNo</th>
					<th>categoryKind</th>
					<th>categoryName</th>
				</tr>
				<%
					for(HashMap<String, Object> m : list) {
						%>
						<tr>
							<td><%=(Integer)m.get("cashNo")%></td>
							<td><%=(String)m.get("cashDate")%></td>
							<td><%=(Integer)m.get("cashPrice")%></td>
							<td><%=(Integer)m.get("categoryNo")%></td>
							<td><%=(String)m.get("categoryKind")%></td>
							<td><%=(String)m.get("categoryName")%></td>
						</tr>
						<%
					}
				%>
			</table>
		</div>
	</body>
</html>