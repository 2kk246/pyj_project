<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.Properties" %>
<%@ page import="javax.mail.*, javax.mail.internet.*,java.util.Random, org.json.simple.*" %>

<%
	int result=0;
	request.setCharacterEncoding("UTF-8");
	
	String memberId = request.getParameter("memberId"); //비밀번호가 내용임
	session.setAttribute("sessionId", memberId); //세션에 아이디 설정
	response.setContentType("text/html;charset=UTF-8");

	Properties properties = new Properties();//서블릿과 다른점
	properties.put("mail.smtp.starttls.enable", "true");
	properties.put("mail.smtp.host", "smtp.gmail.com");
	properties.put("mail.smtp.auth", "true");
	properties.put("mail.smtp.port", "587");
	properties.put("mail.transport.protocol", "smtp");
	properties.put("mail.debug", "true");
	properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
	
	Authenticator auth = new Authenticator() {
		//구글 계정 정보 입력해서 인증받음(구글 계정 아이디, 앱 비밀번호로 생성된 비밀번호)
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("chesye21", "kctosnzpniokubwe");
		}
		
	};
	
	Session s = Session.getDefaultInstance(properties, auth);
	Message message = new MimeMessage(s);
	Address sender_address = new InternetAddress("chesye21@gmail.com");
	Address receiver_address = new InternetAddress(memberId);
	
	message.setHeader("content-type", "text/html;charset=UTF-8");
	message.setFrom(sender_address);
	message.addRecipient(Message.RecipientType.TO, receiver_address);
	message.setSubject("비밀번호 재설정 코드가 도착했습니다");
	
	//5자리 영문+숫자 랜덤코드 생성
	Random rnd =new Random();
	StringBuffer buf =new StringBuffer();
	for(int i=0;i<5;i++){
	    // rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.
	    if(rnd.nextBoolean()){
	        buf.append((char)((int)(rnd.nextInt(26))+97));
	    }else{
	        buf.append((rnd.nextInt(10)));
	    }
	}

	message.setContent(buf.toString(), "text/html;charset=UTF-8");
	message.setSentDate(new java.util.Date());
	Transport.send(message);
	result=1; //메일이 정상 발송됨
	
	JSONArray jArray = new JSONArray();
	JSONObject jObj = new JSONObject();
	jObj.put("result",result); //키, 값
	jObj.put("code",buf.toString());
	jArray.add(jObj);
%>
<%=jArray.toJSONString()%>