<%@page import="dao.AddGoodsDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//insertProductAction
	
	// String uploadPath = request.getServletContext().getRealPath("/upload");
	String uploadPath = "/Users/jkh/Desktop/DB/mall-gitRepository/mall/mall/src/main/webapp/upload";
	MultipartRequest req = new MultipartRequest(
		request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	
	// 추가한 파일에 대한 정보들
	String contentType = req.getContentType("goodsImg");
	String filename = req.getFilesystemName("goodsImg"); // 저장된 파일 이름
	String originName = req.getOriginalFileName("goodsImg"); // 추가했을 당시의 파일 이름
	
	if(!(contentType.equals("image/png") || contentType.equals("image/jpeg") || contentType.equals("image/jpg"))) {
		
		// 파일의 확장자가 이미지확장자가 아니라면 이미 업로드된 파일삭제
		File f = new File(uploadPath+"/"+filename); // 저장된 파일위치에서 불러오기
		if(f.exists()) { // 파일이 존재한다면
			f.delete(); // 파일 삭제
		}
		
		String msg = URLEncoder.encode("이미지 파일만 저장 가능합니다.");
		response.sendRedirect(request.getContextPath()+"/addGoods.jsp?msg="+msg);
		return;	
	}
	
	// form에서 입력한 정보들
	String goodsTitle = req.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(req.getParameter("goodsPrice"));
	String goodsMemo = req.getParameter("goodsMemo");
	
	AddGoodsDao addGoodsDao = new AddGoodsDao();
	addGoodsDao.addGoods(goodsTitle, goodsPrice, goodsMemo, contentType, filename, originName);
	
	response.sendRedirect(request.getContextPath()+"/goodsList.jsp");
	
%>