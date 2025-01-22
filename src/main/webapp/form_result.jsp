<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String directory = "C:/image";
	int sizeLimit = 100*1024*1024;		//100MB 제한
	
	MultipartRequest multi = new MultipartRequest(request, 
					directory, 
                    sizeLimit,
                    "UTF-8",
   	                new DefaultFileRenamePolicy() );
%>	