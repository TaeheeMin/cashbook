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
	
	String memberId = request.getParameter("memberId");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	System.out.println(request.getParameter("cashNo") + "<- upCashAc cashNo");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// 디버깅
	System.out.println(memberId + "<- upCashAc Id");
	System.out.println(categoryNo + "<- upCashAc categoryNo");
	System.out.println(cashDate + "<- upCashAc cashDate");
	System.out.println(cashMemo + "<- upCashAc cashMemo");
	/* 
	// 작성 확인
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("") ||
		request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("")||
		request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("") ||
		request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")){
		String insertMsg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cashList.jsp?msg="+insertMsg+"&year="+year+"&month="+month+"&day="+date);
		return;
	} // 내용 미입력시 메세지, 폼이동
	 */
	Cash paramCash = new Cash();
	//paramCash.setCsahNo(cashNo);
	paramCash.setCategoryNo(categoryNo);
	paramCash.setCashPrice(cashPrice);
	paramCash.setCashNo(cashNo);
	paramCash.setCashMemo(cashMemo);
	
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.updateCash(paramCash);
	String redirectUrl = null;
	
	if(resultRow == 1){
		//삭제성공
		System.out.println("수정성공");
		String msg = URLEncoder.encode("수정성공","utf-8");
		redirectUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+(month)+"&day="+date+"&day="+"&cahsNo="+cashNo;
	} else {
		String msg = URLEncoder.encode("수정실패","utf-8");
		redirectUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+(month)+"&day="+date+"&day="+"&cahsNo="+cashNo;
		System.out.println(resultRow + "<- upCashAc resultRow");
		
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
	

%>