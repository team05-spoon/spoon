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
        // CSRF 정보 가져오기
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

            // PortOne V2 성공 조건: response.code가 없거나 undefined인 경우
            if (response.paymentId) {
                $.ajax({
                    url: "/payments/complete",
                    method: "POST",
                    contentType: "application/json",
                    // AJAX 요청 시 CSRF 헤더 전송
                    beforeSend: function(xhr) {
                        if(header && token) xhr.setRequestHeader(header, token);
                    },
                    data: JSON.stringify({ 
                        paymentId: response.paymentId,
                        orderName: "${orderName}"
                    }),
                    success: function(res) {
                        if(res.trim() === "success") {
                            // 여기가 바로 성공 화면 이동입니다!
                            location.href = "/payments/success";
                        } else {
                            alert("DB 저장 오류: " + res);
                        }
                    },
                    error: function(xhr) {
                        alert("서버 통신 실패: " + xhr.status);
                    }
                });
            } else {
                alert("결제에 실패하였습니다: " + response.message);
            }
        } catch (e) {
            alert("결제 프로세스 중 오류 발생");
        }
    }
</script>
</body>
</html>