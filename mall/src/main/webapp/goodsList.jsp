<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.GoodsListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>상품 목록</title>
	<link rel="icon" href="img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">

  <link rel="stylesheet" href="css/style.css">
  
  <!--구글폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/font.css">
  
  <!-- 아이콘 -->
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
  />
</head>
<body>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 6;
	
	GoodsListDao goodsListDao = new GoodsListDao();
	int totalRow = goodsListDao.goodsListPaging();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	int beginRow = (currentPage-1)*rowPerPage;
	
	ArrayList<HashMap<String, Object>> list = goodsListDao.selectGoodsList(beginRow, rowPerPage);
%>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/menu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->

          <!-- Start Paging Bar -->
          <div class="filter-bar d-flex flex-wrap align-items-center">
          	<div class="sorting mr-auto">
        
          		<%
          			if(currentPage > 1) {
          		%>	
          				<a class="btn btn-light" href="<%=request.getContextPath()%>/goodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
          		<%
          			}
          		%>
          		
          		<%
					if(currentPage < lastPage) {
				%>
						<a class="btn btn-light" href="<%=request.getContextPath()%>/goodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%		
					}
				%>

          	</div>
      
            <div>
              <div class="input-group filter-bar-search">
                <input type="text" placeholder="Search">
                <div class="input-group-append">
                  <button type="button"><i class="ti-search"></i></button>
                </div>
              </div>
            </div>
          </div>
          <!-- End Paging Bar -->
   
          
          <!-- Start goods list -->
          <section class="lattest-product-area pb-40 category-list container">
            <div class="row">
         <%
         	for(HashMap<String, Object> map : list) {
         %>
         		<div class="col-md-6 col-lg-4">
                <div class="card text-center card-product">
                  <div class="card-product__img">
                    <img class="card-img" src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>">
                    <ul class="card-product__imgOverlay">
                      <li>
                      	<button type="button" onclick="location.href='<%=request.getContextPath()%>/goodsOne.jsp?goodsNo=<%=map.get("goodsNo")%>'"><i class="ti-search"></i></button>
                      </li>
                      <li><button><i class="ti-shopping-cart"></i></button></li>
                    </ul>
                  </div>
                  <div class="card-body">
                    <h4 class="card-product__title"><%=map.get("goodsTitle")%></h4>
                    <p class="card-product__price"><%=map.get("goodsPrice")%> 원</p>
                  </div>
                </div>
              </div>
         <%
         		System.out.println(map.get("filename") + " <-- filename");
         	}
         %>             
            </div>
          </section>
          <!-- End goods list -->

	<!-- ================ category section end ================= -->		  



  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/nouislider/nouislider.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>