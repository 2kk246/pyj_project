<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.io.File.*, java.net.URLEncoder" %>

<%
	//다운로드할 파일의 저장소 경로
	String downloadPath = new File("C:/Temp/FileUpload").getAbsolutePath();

	request.setCharacterEncoding("UTF-8");
	String systemFileName = request.getParameter("sys_file");
	System.out.println(systemFileName);
	//업로드된 파일 다운로드하기
	FileInputStream fis = new FileInputStream(downloadPath+"/"+systemFileName);
	BufferedInputStream bis = new BufferedInputStream(fis);
	
	//response객체에 다운로드 내용에 대한 세팅
	//1.MIME 타입 세팅
	String mimeType = getServletContext().getMimeType(systemFileName);
	if(mimeType == null) mimeType="application/octet-stream";
	response.setContentType(mimeType);
	
	//2. attachment; filename 세팅
	//웹브라우저 판별(IE와 그 외)
	String agent = request.getHeader("User-agent");
	boolean ie = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1); //-1:없음
	if(ie){
		systemFileName = URLEncoder.encode(systemFileName, "UTF-8").replaceAll("\\+", "%20"); //코드를 바꿈
	}else{
		systemFileName = new String(systemFileName.getBytes("UTF-8"),"iso-8859-1"); //알파벳문자셋
	}
	response.setHeader("Content-Disposition", "attachment; filename="+systemFileName); //속성값 세팅
	
	//입력과 출력객체를 이용해서 응답내용에 파일 출력하기
	OutputStream os = response.getOutputStream();
	BufferedOutputStream bos = new BufferedOutputStream(os);
	
	byte [] buffer = new byte[4096];
	int readByte;
	while((readByte=bis.read(buffer, 0, buffer.length)) != -1){
		bos.write(buffer, 0, readByte);
	}
	
	bos.close();
	bis.close();
%>