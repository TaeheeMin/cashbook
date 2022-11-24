<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");

	// 1. controller
	String memberId = request.getParameter("memberId");
	int catagoryNo = Integer.parseInt(request.getParameter("catagoryNo"));
	String cashDate = request.getParameter("cashDate");
	int cashPrice = Integer.parseInt(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	// 디버깅
	System.out.println("insCashAc Id" + memberId);
	System.out.println("insCashAc catagoryNo" + catagoryNo);
	System.out.println("insCashAc cashDate" + cashDate);
	System.out.println("insCashAc cashPrice" + cashPrice);
	System.out.println("insCashAc cashMemo" + cashMemo);
	
	// 작성 확인
	if(memberId == null || catagoryNo == 0 || cashDate == null || cashPrice == 0 || cashMemo == null || 
		memberId.equals("") || cashDate.equals("") || cashMemo.equals("")){
		String insertMsg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cashDateList.jsp?msg="+insertMsg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	// 2. model
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.insertCash(catagoryNo, cashDate, cashMemo, memberId, cashPrice);
	String msg = URLEncoder.encode("작성실패","utf-8");
	String redirectUrl = "/cash//cashList.jsp?msg="+msg;
	System.out.println("inserCashAction resultRow : " + resultRow);
	
	if(resultRow == 1){
		//삭제성공
		System.out.println("작성성공");
		msg = URLEncoder.encode("작성성공","utf-8");
		redirectUrl = "/cash/cashList.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>