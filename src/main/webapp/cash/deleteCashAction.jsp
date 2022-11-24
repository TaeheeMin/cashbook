<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// 폼에서 비밀번호, cashno, memberId 받고(입력값) -> 메서드로 삭제 처리-> 반환값 없음 -> 리스트로 복귀
	request.setCharacterEncoding("utf-8");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	// 디버깅
	System.out.println(memberId + "<- delCashAc Id");
	System.out.println(memberPw + "<- delCashAc pw");
	System.out.println(cashNo + "-< delCashAc cashNo");

	// 작성 확인
	if(memberPw == null || memberPw.equals("")){
		String msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.deleteCash(cashNo, memberId, memberPw);
	String msg = URLEncoder.encode("삭제실패","utf-8");
	String redirectUrl = "/cash/cashList.jsp?msg="+msg;
	System.out.println(resultRow + "<- deleCashAc resultRow");
	
	if(resultRow == 1){
		//삭제성공
		System.out.println("삭제성공");
		msg = URLEncoder.encode("삭제성공","utf-8");
		redirectUrl = "/cash/cashList.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>