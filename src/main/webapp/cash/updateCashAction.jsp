<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	// controller : session 검증
	// 로그인 세션 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// 작성 확인
	if(request.getParameter("categoryNo") == null || request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null ||
		request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")){
		String msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		String redirectUrl = "/cash/updateCashForm.jsp?cashNo="+request.getParameter("cashNo")+"&msg="+msg+"&year="+ year+"&month="+month+"&day="+date;
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	String memberId = request.getParameter("memberId");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	Cash cash = new Cash();
	cash.setCashNo(cashNo);
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashNo(cashNo);
	cash.setCashMemo(cashMemo);
	cash.setMemberId(memberId);
	
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.updateCash(cash);

	String msg = URLEncoder.encode("수정실패","utf-8");
	String redirectUrl = "/cash/cashUpdateForm.jsp?msg="+msg;
	
	if(resultRow == 1){
		System.out.println("수정성공");
		msg = URLEncoder.encode("수정성공","utf-8");
		redirectUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+(month)+"&day="+date+"&day="+"&cahsNo="+cashNo;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>