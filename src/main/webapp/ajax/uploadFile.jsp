<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, java.io.*, java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy, org.json.simple.*" %>
<%
	String uploadPath = new File("C:/Temp/FileUpload").getAbsolutePath();
	
	int maxSize = 10*1024*1024;
	MultipartRequest mr = new MultipartRequest(request, 
											   uploadPath, 
											   maxSize, 
											   "UTF-8", 
											   new DefaultFileRenamePolicy());
	
	///클라이언트가 업로드한 파일명을 MultipartRequest객체를 통해서 얻음///
	
	//1. <form>태그의 <input type="file">의 이름들(uploadfile,...)을 반환받음
	Enumeration fileTypeNames = mr.getFileNames();
	
	//2. <input type="file"> 태그의 name을 이용해 value값(업로드한 파일명)을 얻음
	String fileName = (String)fileTypeNames.nextElement();
	
	String systemFileName = mr.getFilesystemName(fileName);
	String originalFileName = mr.getOriginalFileName(fileName);
	
	JSONArray jArray = new JSONArray();
	JSONObject jObj = new JSONObject();
	jObj.put("bbsFRoute",systemFileName); //키, 값
	jObj.put("bbsFRoute2",originalFileName);
	jArray.add(jObj);
%>
<%=jArray.toJSONString()%>