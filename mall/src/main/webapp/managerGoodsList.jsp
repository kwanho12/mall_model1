<%@page import="dao.GoodsDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
	// 세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}	

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 6;	
	
	GoodsDao goodsDao = new GoodsDao();
	int totalRow = goodsDao.goodsListPaging();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	int beginRow = (currentPage-1)*rowPerPage;
	
	ArrayList<HashMap<String, Object>> list = goodsDao.selectGoodsList(beginRow, rowPerPage);
%>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/managerMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->

          <!-- Start Paging, search Bar -->
          <div class="filter-bar d-flex flex-wrap align-items-center">
          	<div class="sorting mr-auto">
        
          		<%
          			if(currentPage > 1) {
          		%>	
          				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerGoodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
          		<%
          			}
          		%>
          		
          		<%
					if(currentPage < lastPage) {
				%>
						<a class="btn btn-light" href="<%=request.getContextPath()%>/managerGoodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%		
					}
				%>

          	</div>
      
            <form action="<%=request.getContextPath()%>/managerGoodsSearchList.jsp">
      			<div>
	              <div class="input-group filter-bar-search">
	              
	              	<table>
	              		<tr>
	              			<td>
	              				<select name="searchField">
									<option value="select">선택</option>
									<option value="title">이름</option>
									<option value="memo">상세 설명</option>
								</select>
	              			</td>
	              			<td>
	              				<input type="text" placeholder="입력" name="searchText" class="col">	 
	              			</td>
	              			<td>
	              				<div >
			                  		<button style="height:38px;"><i class="ti-search"></i></button>
			              		</div>
	              			</td>
	              		</tr>
	              	</table>
	              		
              	  </div>
            	</div>
      		 </form>
      		
      		</div>
          <!-- End Paging, search Bar -->
   
          
          <!-- Start goods list -->
          <section class="lattest-product-area pb-40 category-list container">
            <div class="row">
         <%
         	for(HashMap<String, Object> map : list) {
         %>
         		<div class="col-md-6 col-lg-4">
                <div class="card text-center card-product">
                  <div class="card-product__img">
                    <img class="card-img" src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" style="width:380px; height:380px;">
                    <ul class="card-product__imgOverlay">
                      <li>
                      	<button type="button" onclick="location.href='<%=request.getContextPath()%>/managerGoodsOne.jsp?goodsNo=<%=map.get("goodsNo")%>'"><i class="ti-search"></i></button>
                      </li>
                      <li>
						<button type="button" onclick="location.href='<%=request.getContextPath()%>/deleteGoodsAction.jsp?goodsNo=<%=map.get("goodsNo")%>&currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>'"><i class="fa-solid fa-x"></i></button>
					  </li>
                    </ul>
                  </div>
                  <div class="card-body">
                    <h4 class="card-product__title"><%=map.get("goodsTitle")%></h4>
                    <p class="card-product__price"><%=map.get("goodsPrice")%> 원</p>
                  </div>
                </div>
              </div>
         <%

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