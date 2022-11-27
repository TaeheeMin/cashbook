<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	// 1. controller
	// 로그인 세션 정보 확인
	int categoryNo = Integer.parseInt(request.getParameter("catagoryNo"));
	String cashDate = request.getParameter("cashDate");
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	String memberId = request.getParameter("memberId");
	
	// 작성 확인
	if(categoryNo == 0 || cashDate == null || cashPrice == 0 || cashMemo == null || 
		cashDate.equals("") || cashMemo.equals("")){
		String msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?msg="+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// 2. model
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setMemberId(memberId);
	cash.setCashDate(cashDate);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.insertCash(cash);
	String msg = URLEncoder.encode("작성실패","utf-8");
	String redirectUrl = "/cash//cashList.jsp?msg="+msg;
	
	if(resultRow == 1){
		msg = URLEncoder.encode("작성성공","utf-8");
		redirectUrl = "/cash/cashList.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>