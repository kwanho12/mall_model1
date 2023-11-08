<%@page import="dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
	CartDao cartDao = new CartDao();
	int customerNo = (Integer) session.getAttribute("customerNo");
	int cartCount = cartDao.getCartCount(customerNo);
%>
    
<header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
          <a class="navbar-brand logo_h" href="<%=request.getContextPath()%>/home.jsp"><img src="img/logo.png" alt=""></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
          
            <ul class="nav navbar-nav menu_nav mr-auto" style="margin-left:20px;">
       
   				<li class="nav-item submenu dropdown">
			   		<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	                	 aria-expanded="false">상품</a>
           	    <ul class="dropdown-menu">
                 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/goodsList.jsp">상품목록</a></li>
                 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/orderConfirmation.jsp">주문확인</a></li>
                 <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/cart.jsp">장바구니</a></li>
               </ul>       
			</li>
 
              <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/question.jsp">고객센터</a></li>
            </ul>

            <ul class="nav-shop">
              <li class="nav-item"><button><i class="ti-search"></i></button></li>
              <li class="nav-item">
              	<button type="button" onclick="location.href='<%=request.getContextPath()%>/cart.jsp'">       	
              	<i class="ti-shopping-cart"></i>
              	
              	<%
              		if(session.getAttribute("customerNo") != null) {
              	%>		
              			<span class="nav-shop__circle"><%=cartCount%></span>
              	<% 		   
              		}
              	%>
              	   		
              	</button>	 
              </li>
              
             	<%
              		if(session.getAttribute("customerNo") != null) {
              	%>		
              			<li class="nav-item"><a class="button button-header" href="<%=request.getContextPath()%>/orders.jsp">장바구니에 담긴 상품 바로 구매</a></li>
              	<% 		   
              		}
              	%>
  
            </ul>
            <ul>         	
           		<li class="nav-item active"><a class="nav-link" href="<%=request.getContextPath()%>/logoutAction.jsp">로그아웃</a></li>	
            </ul>
            <ul>
           		<li class="nav-item active"><a class="nav-link" href="<%=request.getContextPath()%>/customerOne.jsp?customerNo=<%=customerNo%>">마이페이지</a></li>	
            </ul>
          
          </div>
        </div>
      </nav>
    </div>
  </header>