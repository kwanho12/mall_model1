<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>장바구니</title>
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
  <style>
  
  </style>
</head>
<body>
<%
	int customerNo = 0;
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("customerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	} else {
		customerNo = (Integer) session.getAttribute("customerNo");
	}
	
	// String uploadPath = request.getServletContext().getRealPath("/upload");
	String uploadPath = "/Users/jkh/Desktop/DB/mall-gitRepository/mall/mall/src/main/webapp/upload";

	CartDao cartDao = new CartDao();
	ArrayList<HashMap<String, Object>> list = cartDao.cartList(customerNo);
	
	int totalSum = 0; // 장바구니에 담긴 상품들의 가격의 총합

%>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->


  <!--================Cart Area =================-->
  <section class="cart_area">
      <div class="container">
          <div class="cart_inner">
              <div class="table-responsive">
              	<form action="updateCartAction.jsp">
              	
                  <table class="table">
                  	  <colgroup>
			            <col width=30%>
			            <col width=18%>
			            <col width=18%>
			            <col width=18%>
			            <col width=25%>
     	  			  </colgroup>
                      <thead>
                          <tr>
                              <th scope="col">상품 이름</th>
                              <th scope="col">가격</th>
                              <th scope="col">수량</th>
                              <th scope="col">합계</th>
                              <th scope="col">장바구니에서 제거</th>
                          </tr>
                      </thead>
                      <tbody>
	                      
	                      <!--cartList 시작 -->
	                      <%
	                      	for(HashMap<String, Object> map : list) {
	                      		
	                      		int goodsPrice = (Integer) map.get("goodsPrice");
	                      		int quantity = (Integer) map.get("quantity");
	                      		int goodsSum = goodsPrice * quantity;
	                      		
	                      		totalSum += goodsSum;
	                      		
	                      %>
	                       	
	                      		<tr>  		
	                              <td>
	                                  <div class="media">
	                                      <div class="d-flex">
	                                          <img src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" class="img-fluid" style="width:100px; height:100px" alt="">
	                                      </div>
	                                      <div class="media-body">
	                                          <p><%=map.get("goodsTitle")%></p>
	                                      </div>
	                                  </div>
	                              </td>
	                              
	                              <td>
	                                  <h5><%=map.get("goodsPrice")%> 원</h5>
	                              </td>
	                              <td>
	                                  <div class="product_count">
	                                      <input type="text" name="<%=map.get("cartNo")%>" id="<%=map.get("cartNo")%>" maxlength="12" value="<%=map.get("quantity")%>" title="Quantity:"
	                                          class="input-text qty">
	                                      <button onclick="var result = document.getElementById('<%=map.get("cartNo")%>'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
	                                          class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
	                                      <button onclick="var result = document.getElementById('<%=map.get("cartNo")%>'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
	                                          class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
	                                  </div>
	                              </td>
	                              
	                              <td>
	                                  <h5><%=goodsSum%> 원</h5>
	                              </td>
	                              <td><a href="<%=request.getContextPath()%>/deleteCartAction.jsp?cartNo=<%=map.get("cartNo")%>">삭제</a></td>                            
	                          </tr>
	                      
	                      <%
	                      	}
	                      %>
	                      <!--cartList 끝 -->
	                          
	                          
	                          
	                          <tr class="bottom_button">
	                              <td>
	                              	  <button class="button">Update Cart</button>
								  </td>
	                              <td></td>
	                              <td></td>
	                              <td></td>
	                              <td></td>
	                          </tr>
	                          
	            
	                          <tr>
	                          	  <td></td>
	                              <td></td>
	                              <td></td>
	                              <td>
	                                  <h5>합계</h5>
	                              </td>
	                              <td>
	                                  <h5><%=totalSum%> 원</h5>
	                              </td>
	                          </tr>
	                          <tr class="shipping_area">
	                          	  
	                              <td class="d-none d-md-block">
	
	                              </td>
	                              <td></td>
	                              <td>
	
	                              </td>
	                              <td>
	                                  <h5>배송</h5>
	                              </td>
	                              <td>
	                                  <div class="shipping_box">
	                                      <ul class="list">
	                                          <li class="active"><a href="#">택배 : 2500 원</a></li>
	                                          <li><a href="#">퀵 : 10000 원</a></li>    
	                                      </ul>   
	                                  </div>
	                              </td>
	                          </tr>
	                          <tr class="out_button_area">
	                              <td class="d-none-l"></td>
	                              <td></td>
	                              <td></td>
	                              <td></td>
	                              <td>
	                                  <div class="checkout_btn_inner d-flex align-items-center justify-content-end">
	                                      <a class="gray_btn" href="<%=request.getContextPath()%>/goodsList.jsp">계속 쇼핑하기</a>
	                                      <a class="primary-btn ml-2" href="#">결제하기</a>
	                                  </div>
	                              </td>
	                          </tr>
	                      </tbody>
	                  </table>
	                  
                  </form>
              </div>
          </div>
      </div>
  </section>
  <!--================End Cart Area =================-->


  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>