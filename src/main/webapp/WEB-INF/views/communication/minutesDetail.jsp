<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀별 회의 공간</h3>
						<p class="text-subtitle text-muted">For user to check they
							list</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">DataTable</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="col-12 col-md-6">
	                <div class="card">
	                    <div class="card-header">
	                        <h4 class="card-title">Table without outer spacing</h4>
	                    </div>
	                    <div class="card-content">
	                        <div class="card-body">
	                            <p class="card-text">Using the most basic table up, here’s how
	                                <code>.table</code>-based tables look in Bootstrap. You can use any example
	                                of below table for your table and it can be use with any type of bootstrap tables.
	                            </p>
	                        </div>
	
	                        <!-- Table with no outer spacing -->
	                        <div class="table-responsive">
	                            <table class="table mb-0 table-lg">
	                                <thead>
	                                    <tr>
	                                        <th>NAME</th>
	                                        <th>RATE</th>
	                                        <th>SKILL</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <tr>
	                                        <td class="text-bold-500">Michael Right</td>
	                                        <td>$15/hr</td>
	                                        <td class="text-bold-500">UI/UX</td>
	
	                                    </tr>
	                                    <tr>
	                                        <td class="text-bold-500">Morgan Vanblum</td>
	                                        <td>$13/hr</td>
	                                        <td class="text-bold-500">Graphic concepts</td>
	
	                                    </tr>
	                                    <tr>
	                                        <td class="text-bold-500">Tiffani Blogz</td>
	                                        <td>$15/hr</td>
	                                        <td class="text-bold-500">Animation</td>
	
	                                    </tr>
	                                    <tr>
	                                        <td class="text-bold-500">Ashley Boul</td>
	                                        <td>$15/hr</td>
	                                        <td class="text-bold-500">Animation</td>
	
	                                    </tr>
	                                    <tr>
	                                        <td class="text-bold-500">Mikkey Mice</td>
	                                        <td>$15/hr</td>
	                                        <td class="text-bold-500">Animation</td>
	
	                                    </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	            </div>
			</section>
		</div>

	</div>
</body>
</html>