<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script src="echarts.js"></script>
<!-- import vintage theme -->
<script src="theme/vintage.js"></script>
<script>
// The second parameter is the name of the theme imported
var chart = echarts.init(document.getElementById('main'), 'vintage');
chart.setOption({
    ...
});
</script>


<body>

</body>
</html>