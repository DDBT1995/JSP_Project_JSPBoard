<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
response.setHeader("Cache-Control", "no-store"); //매번서버에 요청
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", (long) 0);

if (request.getProtocol().equals("HTTP/1.1")) {
   response.setHeader("Cache-Control", "no-cache");
}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>JSPBoard</title>
<link rel="shortcut icon" href="/resources/images/favicon.ico"type="image/x-icon">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="/resources/css/custom.css"type="text/css">
<script type="text/javascript" src="/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<style>
    @font-face {
        font-family: "GmarketSans";
        font-weight: normal;
        font-style: normal;
        src: url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansMedium.woff') format('woff');
        font-display: swap;
    }

    body {
        font-family: "GmarketSans";
    }
</style>