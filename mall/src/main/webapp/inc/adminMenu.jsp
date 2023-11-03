<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
          <div class="navbar-brand logo_h">관리자 페이지</div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          
          
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
           
              	<li class="nav-item submenu dropdown">  
					<a href="<%=request.getContextPath()%>/customerList.jsp" class="nav-link" role="button" aria-haspopup="true"
	                  aria-expanded="false">고객 목록</a>        
				</li>
				<li class="nav-item submenu dropdown">  
					<a href="<%=request.getContextPath()%>/managerGoodsList.jsp" class="nav-link" role="button" aria-haspopup="true"
	                  aria-expanded="false">상품 목록</a>        
				</li>
				<li class="nav-item submenu dropdown">  
					<a href="<%=request.getContextPath()%>/addGoods.jsp" class="nav-link" role="button" aria-haspopup="true"
	                  aria-expanded="false">상품 추가</a>        
				</li>
				
            </ul>

            <ul>          	
           		<li class="nav-item active"><a class="nav-link" href="<%=request.getContextPath()%>/managerLogoutAction.jsp">로그아웃</a></li>          
            </ul>          
          </div>
        </div>
      </nav>
    </div>
  </header>