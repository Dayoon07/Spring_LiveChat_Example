<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅 화면</title>
</head>
<body>
	<h2>채팅 연습하기</h2>
	<input type="text" id="userid">
	<button onclick="openChatting();">채팅 입장</button>
	<div id="messageContainer" style="
		width: 500px; height: 500px; margin: 0 auto;
		border: 1px solid black; overflow: scroll;
	"></div>
	
	<script>
		let websocket;
		const openChatting = () => {
			// websocket 연결을 하려면 js가 제공하는 WebSocket 객체를 생성한다.
			// 파라미터에 서버매핑주소를 전달
			// ws://서버ip주소:포트번호/contextPath/매핑주소  ->
			// wss://서버ip주소:포트번호/contextPath/매핑주소 ->
			websocket = new WebSocket("ws://localhost:9090/websocket/chating");
			
			// 서버와 통신할 수 있는 핸들러를 등록
			websocket.onopen = (data) => {
				console.log(data);
				const userid = document.querySelector("#userid").value;
				const msg = new Message("enter", userid, '', '');
				// js 객체를 문자열로 변경해주는 함수 => JSON.stringify();
				websocket.send(JSON.stringify(msg));
			}
			websocket.onmessage = (msg) => {
				const message = JSON.parse(msg.data);
				console.log(message);
				console.log(msg.data);
				switch (message.type) {
					case "enter" : appendMessage(message);
				}
			}
		}
		
		function appendMessage(message) {
			const $container = document.getElementById("messageContainer");
			const $h4 = document.createElement("h4");
			$h4.innerText = message.data;
			$h4.style.textAlign = "center";
			$container.appendChild($h4);
		}
		
		class Message {
			constructor(type, sender, receiver, data) {
				this.type = type;
				this.sender = sender;
				this.receiver = receiver;
				this.data = data;
			}
		}
			
		
		
	</script>
</body>
</html>