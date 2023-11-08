<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>주문 확인</title>
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
	
	OrdersDao ordersDao = new OrdersDao();
	ArrayList<HashMap<String, Object>> list = ordersDao.orderList(customerNo);
	
	int subtotal = 0;
	int orderCount = 0;
%>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  
  
  <!--================Order Details Area =================-->
  <section class="order_details">
    <div class="container" style="margin-bottom:50px;">
   		<div style="margin-top : 50px;">
   			<p class="billing-alert">주문 완료되었습니다. 이용해 주셔서 감사합니다.</p>
   		</div>
      
      <!---------------------
      <div class="row mb-5">
      
        <div class="col-md-6 col-xl-4 mb-4 mb-xl-0">
          <div class="confirmation-card">
            <h3 class="billing-title">주문 정보</h3>
            <table class="order-rable">
              <tr>
                <td>주문 번호</td>
                <td>: 60235</td>
              </tr>
              <tr>
                <td>주문 날짜, 시간</td>
                <td>: Oct 03, 2017</td>
              </tr>
              <tr>
                <td>합계</td>
                <td>: USD 2210</td>
              </tr>
            </table>
          </div>
        </div>
        
      </div>
       ----------------------->
      
      
      
      <div>
        <h4>주문 정보</h4>
        <div class="table-responsive">
          <table class="table">
          	<colgroup>
	         	<col width=35%>
	            <col width=21%>
	            <col width=28%>
	            <col width=16%>
          	</colgroup>
            <thead>
              <tr>
                <th>상품</th>
                <th>수량</th>
                <th>합계</th>
                <th>주문 취소</th>
              </tr>
            </thead>
            <tbody>
            
            <%
            for(HashMap<String, Object> map : list) {
            %>
            
              <tr>
                <td>
                  <p><%=map.get("goodsTitle")%></p>
                </td>
                <td>
                  <p><%=map.get("quantity")%> 개</p>
                </td>
                <td>
                  <p><%=map.get("totalPrice")%> 원</p>
                </td>
                <td>
                  <a href="<%=request.getContextPath()%>/deleteOrderAction.jsp?ordersNo=<%=map.get("ordersNo")%>">취소</a>
                </td>
              </tr>
              
             <%
             // 배송비를 제외한 총합 
             subtotal += (Integer) map.get("totalPrice");
             orderCount++;
            }
             %> 

             
              
              <tr>
              	<td>
                  <h4>Subtotal</h4>
                </td>    
                <td>
                  <h5></h5>
                </td>
                <td></td>
                <td>
                  <p><%=subtotal%> 원</p>
                </td>
              </tr>
              <tr>   
              	<td>
                  <h4>배송료</h4>
                </td>
                <td>
                  <h5></h5>
                </td>
                <td></td> 
                <td>
                  <p><%=2500 * orderCount%> 원</p>
                </td>
              </tr>
              <tr>
              	<td>
                  <h4>Total</h4>
                </td>
                <td>
                  <h5></h5>
                </td>
                <td></td>
                <td>
                  <h4><%=subtotal + 2500 * orderCount%> 원</h4>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>
  <!--================End Order Details Area =================-->


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