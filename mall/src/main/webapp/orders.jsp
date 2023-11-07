<%@page import="dao.CartDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CustomerDao"%>
<%@page import="dao.GoodsDao"%>
<%@page import="vo.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>주문</title>
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
  
  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<%
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	int customerNo = 0;
	if(session.getAttribute("customerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	} else {
		customerNo = (Integer) session.getAttribute("customerNo");
	}

	CustomerDao customerDao = new CustomerDao();
	CartDao cartDao = new CartDao();
	ArrayList<HashMap<String,Object>> one = customerDao.customerOne(customerNo);
	ArrayList<HashMap<String, Object>> cartList = cartDao.cartList(customerNo);
	
	String msg = request.getParameter("msg");
	
	int totalSum = 0;
%>

	<!--================ Start Header Menu Area ===============-->
	  <%
	  	if(session.getAttribute("customerNo") != null) {
	  %>
	  		<jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
	  <% 	
	  	} else {
	  %>
	  		<jsp:include page="/inc/customerLogoutMenu.jsp"></jsp:include>
	  <% 	
	  	}
	  %>
  <!--================ End Header Menu Area =================-->
  
  <!--================Order Information Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h4 style="margin-bottom:40px;">배송 정보</h4>
				
			<% 
				for(HashMap<String,Object> map : one) {
			%>				
				<div class="row login_form">
		            <div class="col-md-12 form-group">
		            	<div>이름 : <input type="text" value="<%=map.get("customerName")%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>휴대폰 번호 : <input type="text" value="<%=map.get("customerPhone")%>" readonly></div>
		            </div>      
        	        <div class="col-md-12 form-group">
		            	<div>주소 : <textarea rows="2" cols="50" style="resize:none; border:none; text-align:center;" readonly><%=map.get("address")%></textarea></div>
		            </div> 
		        </div>          			         
			<%
				}
			%>		
			</div>
		</div>
	</section>
	<!--================End Order Information Area =================-->
	
	  <!--================Cart Area =================-->
  <section>
      <div class="container">
      	<h5 style="margin:20px;">상품 정보</h5>
          <div class="cart_inner">
              <div class="table-responsive">

              	<form action="<%=request.getContextPath()%>/ordersAction.jsp">
                  <table class="table">
                  	  <colgroup>
			            <col width=40%>
			            <col width=21%>
			            <col width=21%>
			            <col width=30%>
     	  			  </colgroup>
                      <thead>
                          <tr>
                              <th scope="col">상품 이름</th>
                              <th scope="col">가격</th>
                              <th scope="col">수량</th>
                              <th scope="col">합계</th>
                          </tr>
                      </thead>
                      <tbody>
	                      
	                      <!--cartList 시작 -->
	                      <%
	                      	for(HashMap<String, Object> map : cartList) {
	                      		
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
	                                  	  <div><%=map.get("quantity")%> 개</div>
	                                  </div>
	                              </td>
	                              
	                              <td>
	                                  <h5><%=goodsSum%> 원</h5>
	                              </td>
	                          </tr>
	                      
	                      <%
	                      	}
	                      %>
	                      <!--cartList 끝 -->
	                          
	                          <tr>
	                          	  <td></td>
	                              <td></td>
	                              <td>
	                                  <h5>합계</h5>
	                              </td>
	                              <td>
	                                  <h5><span id="totalSum"><%=totalSum%></span> 원</h5>
	                              </td>
	                          </tr>
	                          <tr class="shipping_area">
	                          	  
	                              <td class="d-none d-md-block">
	
	                              </td>
	       
	                              <td>
	
	                              </td>
	                              <td>
	                                  <h5>배송</h5>
	                              </td>
	                              <td>
	                              
	                              	  <div>
	                              	  	
	                              	  </div>
	                                  <div>
	                                  
	                                  <div>
                                  	  	<input type="radio" id="select" name="ship" value="10000" checked>
                               			<label for="select">선택하기</label>
                                  	  </div>
	                           
                                  	  <div>
                                  	  	<input type="radio" id="parcel" name="ship" value="2500">
                               			<label for="parcel">택배 : 2500원</label>	
                                  	  </div>
                                  		                               
	                                  </div>
	                              </td>
	                          </tr>
	                          <tr class="out_button_area">
	                              <td class="d-none-l"></td>
	                              <td></td>
	                              <td></td>
	                              <td>
	                                  <div class="checkout_btn_inner d-flex align-items-center justify-content-end">
	                                      <a class="gray_btn" href="<%=request.getContextPath()%>/goodsList.jsp">계속 쇼핑하기</a>
	                                      <button class="primary-btn ml-2" id="checkout">결제하기</button>
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
  
	<script>
		// 배송비 선택시 화면에 추가된 금액이 보이게 하기
		$('#parcel').click(function(){
			$('#totalSum').text(<%=totalSum + 2500%>);
		});
		
		$('#checkout').click(function(){
			
			if( $('#select').is(':checked') ) {
				alert('배송 방법을 선택해주세요.')
			}
			
		});
		
	</script>	
	
	
	


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