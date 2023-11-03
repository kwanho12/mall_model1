<%@page import="vo.Goods"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dao.UpdateGoodsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		// String uploadPath = request.getServletContext().getRealPath("/upload");
		String uploadPath = "/Users/jkh/Desktop/DB/mall-gitRepository/mall/mall/src/main/webapp/upload";
		
		MultipartRequest req = new MultipartRequest(
			request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
		
		Goods g = new Goods();
		g.setGoodsNo(Integer.parseInt(req.getParameter("goodsNo")));
		g.setGoodsTitle(req.getParameter("goodsTitle"));
		g.setGoodsPrice(Integer.parseInt(req.getParameter("goodsPrice")));
		g.setSoldout(req.getParameter("soldout"));
		g.setGoodsMemo(req.getParameter("goodsMemo"));
		
		// 수정 후 파일의 원래 이름 
		String updateName = req.getOriginalFileName("goodsImg");
		// 수정 후 파일의 저장 이름
		String name = req.getFilesystemName("goodsImg");
		// 수정 후 파일의 content-type
		String contentType = req.getContentType("goodsImg");
		
		UpdateGoodsDao updateGoodsDao = new UpdateGoodsDao();
		updateGoodsDao.updateGoods(g, updateName, name, contentType, uploadPath);
		
		response.sendRedirect(request.getContextPath()+"/goodsOne.jsp?goodsNo="+g.getGoodsNo());
%>