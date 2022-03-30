<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  
  <h1>앞으로 우리가 사용하게 될 로그인 페이지입니다.</h1>
  <h1>그레디언트의 메인페이지가 될 것입니다.</h1>
  <h1>Custom Login Page</h1>
  <h2><c:out value="${error}"/></h2>
  <h2><c:out value="${logout}"/></h2>
  
  <form method='post' action="/project5/login">
  <div>
    <input type='text' name='username' value='himan'>
  </div>
  <div>
    <input type='password' name='password' value='7777'>
  </div>
  <div>
  <div>
    <input type='checkbox' name='remember-me'> Remember Me
  </div>
  <div>
    <input type='submit' value="제출하기">
  </div>
    <input type="hidden" name="${_csrf.parameterName}"
    value="${_csrf.token}" />
  
  </form>
  
</body>
</html>
