<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testjQueryAjax</title>
<script type="text/javascript" src="/testa/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	//jQuery(document).ready(function(){//이벤트 처리 코드 작성});
	//$(); = jQuery(document).ready
	$(function(){
		$("#test1").click(function(){
			//컨트롤러를 요청하고 결과로 문자열만 받는 경우
			//jQuery.get() 메소드 사용
			//$.get("요청url", {전달이름: 전달값}, 리턴값 받아 처리할 콜백함수);
			//get 방식으로 요청됨
			$.get("/testa/t1.do", function(data/*서블릿이 보낸 값 받아주는 함수, 매개변수(data) 있어야 함*/){
				$("#p1").text(data);
			});
			
			//jQuery.ajax() 메소드 사용
			$.ajax({
				//연견할 대상
				url: "/testa/t1.do",
				type: "get",
				success: function(data){
					$("#p1").html($("#p1").text() + "<br>" + data);
				}
			}); //ajax 닫기
		}); //click 닫기
	}); //함수 닫기
	
	$(function(){
		$("#test2").click(function(){
			$("#p1").empty();
		})
	});
	
	$(function(){
		$("#test3").click(function(){
			//전송방식이 get 일 때는
			//jQuery.get()과 jQuery.ajax() 중 선택 사용
			//$.get() 사용시
			$.get("/testa/t2.do", 
					{userid: $("#userid").val(), 
					userpwd: $("#userpwd").val()},/*중괄호 안은 객체를 말한다*/
					function(data){
						$("#p2").text(data);
						//input의 기록된 값 지우기 처리
						$("#userid").val("");
						$("#userpwd").val("");
					});
			//$.ajax() 사용시
			$.ajax({
				url: "/testa/t2.do",
				type: "get",
				//서블릿 값으로 보낼 값 지정
				data: {userid: $("userid").val(), 
						userpwd: $("userpwd").val()},
				success: function(returnValue){
					$("#p2").html($("#p2").text() + "<br>" + returnValue);
					$("#userid").val("");
					$("#userpwd").val("")
				}		
			});	//ajax
		
		});//click
	});//ready
	
	$(function(){
		//전송방식을 post로 할 경우
		//jQuery.post() 와 jQuery.ajax() 중 선택 사용
		//$.post() 사용시
		$("#test4").click(function(){
		 $.post("/testa/t3.do",
				{title : $("#title").val(),
				writer : $("#writer").val(),
				content : $("#content").val() 
				}); 
	
		
 		 //$.ajax 사용시
		 $.ajax({
			url : "/testa/t3.do",
			data : {title : $("#title").val(),
					writer : $("#writer").val(),
					content : $("#content").val()},
			type : "post"
			
		});  
 		 
	
		
		}); //click;
	}); //ready
	
	$(function(){
		$("#test5").click(function(){
			//jQuery.getJSON()과 jQuery.ajax() 중 선택
			//$.getJSON() 사용시
			$.getJSON("/testa/t4.do",
						{no : $("#no").val()},
						function(data){
							console.log(data);
							//한 개의 json 객체가 문자열 형태로 전송이 왔을때는 받아서 바로 사용함
							//한글 깨짐을 막기 위해 문자 인코딩 처리한 값은 디코딩 처리함 : 자바스크립트 내장함수인 
							//decodeURIComponent() 사용함
							$("#p4").text(data.no + ", " + data.userid + ", " + data.userpwd + ", " + decodeURIComponent(data.username) 
								+ ", " + data.age + ", " + data.email + ", " + data.phone);
						});
			//$.ajax() 사용시
			$.ajax({
				url: "/testa/t4.do",
				data: {no : $("#no").val()},
				type: "get",
				dataType: "json",
				success: function(data){
					$("#p4").html($("#p4").text() + "<br>" +
							data.no + ", " + data.userid + ", " + data.userpwd + ", " + decodeURIComponent(data.username) 
							+ ", " + data.age + ", " + data.email + ", " + data.phone);
				}
			});
		});	//click
	}); //ready
	
	$(function(){
		$("#test6").click(function(){
			//jQuery.getJSON()과 jQuery.ajax() 중 선택사용
			//$.getJSON() 사용시
			$.getJSON("/testa/t5.do", {no: $("#no2").val()},
					function(data){
						console.log(data); //object 출력됨
						//배열객체를 문자열 형태로 바꿈
						var jsonStr = JSON.stringify(data);
			});
			
		}); //click
	}); //ready
	
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Do+Hyeon');
</style>

<style type="text/css">
#test1{
	background-color : #a593df;
	border: 2px solid #a593df;
	color : white;
	padding : 15px 15px;
	text-align : center;
	font-size : 20px;
	margin : 60px 30px;
	transition-duration : 0.4s;
	cursor: pointer;
	font-family: 'Do Hyeon', sans-serif;
	border-radius: 12px;
	display: inline-block;
}
#test1:hover{
	background-color: white; 
	color: black; 
	border: 2px solid #a593df; 
}
body{
	font-family: 'Do Hyeon', sans-serif;
}

#test2{
	background-color : #a593df;
	border : none;
	color : white;
	padding : 15px 15px;
	text-align : center;
	font-size : 20px;
	margin : 60px 30px;
	transition-duration : 0.4s;
	cursor: pointer;
	font-family: 'Do Hyeon', sans-serif;
	border-radius: 12px;
	display: inline-block;
}
#test2:hover{
	background-color: white; 
	color: black; 
	border: 1px solid #a593df;
}
</style>
</head>
<body>
<h1>jQuery로 ajax 테스트</h1>
<hr>
<h2>1. 서버로 보내는 값 없고, 결과로 문자열 받아 출력 처리하는 방법  : get 방식</h2>
<p id="p1" style="width:300px; height:50px; border:1px solid red"></p>
<button id="test1">테스트</button>
<button id="test2">지우기</button>
<!-- jquery ajax 사용1 -->

<h2>2. 서버로 값을 보내고, 결과로 문자열을 받아 출력 처리하는 방법 : get 방식</h2>
아이디 : <input type="text" id="userid"> <br>
암 &nbsp;호 : <input type="password" id="userpwd"> <br>
<p id="p2" style="width:300px; height:50px; border:1px solid red;"></p>
<button id="test3">테스트</button>
<hr>
<br>
<h2>3. 서버로 여러 개의 값들을 보내고, 결과를 안 받는 경우 : post 방식</h2>
제 &nbsp;목 : <input type="text" id="title"> <br>
작성자 : <input type="text" id=writer> <br>
내 &nbsp;용 : <textarea rows="5" cols="50" id="content"></textarea> <br>
<button id="test4">테스트</button>
<hr>
<br>

<h2>4. 서버로 값 보내고 결과를 JSON으로 받아 출력하는 방법 : get 방식</h2>
번호 : <input type="number" id="no"> <br>
<p id="p4" style="width:500px; height:150px; border:1px solid red;"></p>
<button id="test5">테스트</button>
<hr>
<br>

<h2>5. 서버로 값 보내고, 결과로 list나 map을 json 배열로 받아 출력 처리하는 방법</h2>
번호 : <input type="number" id="no2"> <br>
<p id="p5" style="width:500px; height:300px; border:1px solid red;"></p>
<button id="test6">테스트</button>
</body>
</html>