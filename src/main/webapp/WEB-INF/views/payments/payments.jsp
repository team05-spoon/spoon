<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>Spoon 결제</title>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body { font-family: sans-serif; background: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .pay-box { background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 400px; text-align: center; }
    .btn-pay { background: #fee500; border: none; padding: 15px; width: 100%; font-weight: bold; border-radius: 5px; cursor: pointer; margin-top: 20px; }
</style>
</head>
<body>
<div class="pay-box">
    <h2>결제 진행</h2>
    <p>주문명: ${orderName}</p>
    <p>결제금액: <strong>${totalAmount}원</strong></p>
    <button class="btn-pay" onclick="requestPay()">카카오페이 결제하기</button>
</div>

<script>
    async function requestPay() {
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        try {
            const mId = "${member.m_id}";
            const userEmail = mId.includes('@') ? mId : mId + "@spoon.com";

            const response = await PortOne.requestPayment({
                storeId: "store-d97e3b6b-0d6c-4b4a-95a7-c9bec3a67cab",
                channelKey: "channel-key-d7f80521-1c45-4d4f-9cf5-1f13dddf56e5",
                paymentId: "order_" + new Date().getTime(),
                orderName: "${orderName}",
                totalAmount: Number("${totalAmount}"),
                currency: "KRW",
                payMethod: "EASY_PAY",
                customer: {
                    fullName: "${member.m_name}",
                    phoneNumber: "${member.m_tel}",
                    email: userEmail
                }
            });

            // ✅ 수정된 성공 조건 (V2에서는 code가 존재하지 않아야 성공임)
            if (response.code == null) { 
                $.ajax({
                    url: "/payments/complete",
                    method: "POST",
                    contentType: "application/json",
                    beforeSend: function(xhr) {
                        if(header && token) xhr.setRequestHeader(header, token);
                    },
                    // ✅ 중요: 컨트롤러에서 ordersDTO로 바로 받을 수 있게 데이터를 구성합니다.
                    data: JSON.stringify({ 
                        paymentId: response.paymentId,
                        // orderwriteForm에서 넘어왔던 주문 정보들을 여기서 함께 보냅니다.
                        o_name: "${orderData.o_name}",
                        o_tel: "${orderData.o_tel}",
                        o_addr: "${orderData.o_addr}",
                        d_name: "${orderData.d_name}",
                        d_tel: "${orderData.d_tel}",
                        d_addr: "${orderData.d_addr}",
                        i_no: "${orderData.i_no}",
                        c_count: "${orderData.c_count}",
                        c_price: "${orderData.c_price}"
                    }),
                    success: function(res) {
                        if(res.trim() === "success") {
                            location.href = "/order/orderlist"; // 주문 목록으로 이동
                        } else {
                            alert("주문 처리 중 오류 발생: " + res);
                        }
                    },
                    error: function(xhr) {
                        alert("서버 통신 실패: " + xhr.status);
                    }
                });
            } else {
                // 결제창을 닫거나 실패한 경우
                alert("결제가 취소/실패되었습니다: " + response.message);
            }
        } catch (e) {
            console.error(e);
            alert("결제 프로세스 중 오류 발생");
        }
    }
</script>
</body>
</html>