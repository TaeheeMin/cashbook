<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");
	String msg = URLEncoder.encode("수정 실패","utf-8");
	String redirectUrl = "/admin/memberList.jsp?msg=";
	System.out.println(request.getParameter("memberId"));
	System.out.println(request.getParameter("memberName"));
	System.out.println(request.getParameter("memberLevel"));
	
	// 작성 확인
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberName") == null || request.getParameter("memberName").equals("")
		|| request.getParameter("memberLevel") == null || request.getParameter("memberLevel").equals("")){
		msg = URLEncoder.encode("내용을 입력하세요", "utf-8");
		redirectUrl = "/admin/updateMemberForm.jsp?memberNo="+request.getParameter("memberNo")+"&msg=";
		response.sendRedirect(request.getContextPath()+redirectUrl+msg);
		return;
	} // 내용 미입력시 메세지, 폼이동
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	Member member = new Member();
	member.setMemberLevel(memberLevel);
	member.setMemberName(memberName);
	member.setMemberNo(memberNo);
	
	MemberDao memberDao = new MemberDao();
	int updateMember = memberDao.updateMemberByAdmin(member);
	System.out.println(updateMember);
	if(updateMember == 1){
		msg = URLEncoder.encode("수정 성공","utf-8");
	}
	response.sendRedirect(request.getContextPath()+redirectUrl+msg);
%>