package test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import test.model.vo.User;

/**
 * Servlet implementation class TestServlet5
 */
@WebServlet("/t5.do")
public class TestServlet5 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestServlet5() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// test5 버튼 클릭시 요청되는 컨트롤러 
		// 숫자라서 인코딩 처리 필요 없음
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("t5 : " + no);
		
		ArrayList<User> userList = new ArrayList<User>();
		userList.add(new User("u12345", "p12345", "오오오", 20, "hhh@gmail.com", "010-1234-5678"));
		userList.add(new User("asdf55", "12334", "나나나", 22, "jjj@gmail.com", "010-0000-0000"));
		userList.add(new User("kk777", "sdfad", "도도도", 23, "iii@gmail.com", "010-8888-8888"));
		userList.add(new User("qqwe1", "qwre", "이이이", 24, "qqq@gmail.com", "010-7777-7777"));
		userList.add(new User("ccc9211", "vfvsfv", "김김", 25, "fff@gmail.com", "010-5555-5555"));
		
		//전송할 json 객체 준비
		JSONObject sendJson = new JSONObject();
		
		//리스트 객체들을 저장할 json 배열 객체 준비
		JSONArray jsonArr = new JSONArray();
		
		//리스트(또는 맵)에서 객체를 하나씩 꺼냄
		for(User user : userList) {
			//꺼낸 user 객체 정보를 저장할 json 객체 준비
			JSONObject userJson = new JSONObject();
			
			//user 객체가 가진 필드값 한 개 씩 꺼내서 
			//userJson에 옮겨 기록 저장하기
			userJson.put("userid", user.getUserId());
			userJson.put("userpwd", user.getUserPwd());
			//json에서 한글 깨짐을 막으려면, java.net.URLEncoder의 encode() 메소드로 인코딩 해줘야함
			userJson.put("username", URLEncoder.encode(user.getUserName(), "utf-8"));
			userJson.put("age", user.getAge());
			userJson.put("email", user.getEmail());
			userJson.put("phone", user.getphone());
			
			//json 객체를 json 배열에 기록 저장
			jsonArr.add(userJson);
		}
		
		//json 배열은 전송할 수 없음
		//전송용 json 객체에 json 배열을 젖아함
		sendJson.put("list", jsonArr);
		System.out.println("t5 : " + sendJson.toJSONString());
		
		//내보내기 : ajax 통신은 출력스트림 필요함
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(sendJson.toJSONString());
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
