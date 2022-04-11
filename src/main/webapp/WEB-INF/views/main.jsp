<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<head>

<!-- 구글 어닐리틱스 -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-SKC411JKMD"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-SKC411JKMD');
</script>


<meta charset="UTF-8">
<title>GRADIENT</title>
<script type="text/javascript">
	$(document).ready(function() {
		var psc = "${psc}";
		console.log("psc : " + psc);
		if (psc == "success") {
			alert("로그인 성공하셨습니다.");
		}

		if (psc == "logout") {
			alert("로그아웃 되었습니다.");
		}
		
			$("#selectLan").val("${param.lang}")
			$("#selectLan").change(function(){
				if($(this).val()!=""){
					location.href="${path}/choiceLan2.do?lang="+$(this).val();
				}else{
					location.href="${path}/choiceLan2.do?lang=korean"
				}
			});
	})
</script>
</head>

<body>
	<%@ include file="chatBot/chatBot.jsp"%>
	<%@ include file="common/header.jsp"%>
<div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <h3>Gradient</h3>
            </div>
            <div class="page-content">
                <section class="row">
                    <div class="col-12 col-lg-9">
                        <div class="row">
                            <div class="col-6 col-lg-3 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="stats-icon purple">
                                                    <i class="iconly-boldShow"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Profile Views</h6>
                                                <h6 class="font-extrabold mb-0">112.000</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="stats-icon blue">
                                                    <i class="iconly-boldProfile"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Followers</h6>
                                                <h6 class="font-extrabold mb-0">183.000</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="stats-icon green">
                                                    <i class="iconly-boldAdd-User"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Following</h6>
                                                <h6 class="font-extrabold mb-0">80.000</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-3 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="stats-icon red">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Saved Post</h6>
                                                <h6 class="font-extrabold mb-0">112</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>Profile Visit</h4>
                                    </div>
                                    <div class="card-body" style="position: relative;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>Profile Visit</h4>
                                    </div>
                                    <div class="card-body" style="position: relative;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>Profile Visit</h4>
                                    </div>
                                    <div class="card-body" style="position: relative;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        
                    </div>
                    
                    
                    
                    
                    <div class="col-12 col-lg-3">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-xl">
                                        <img src="assets/images/faces/1.jpg" alt="Face 1">
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold">${member.name }</h5>
                                        <h6 class="text-muted mb-0">${member.email }</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h4>Recent Messages</h4>
                            </div>
                            <div class="card-content pb-4">
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        <img src="assets/images/faces/4.jpg">
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Hank Schrader</h5>
                                        <h6 class="text-muted mb-0">@johnducky</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        <img src="assets/images/faces/5.jpg">
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Dean Winchester</h5>
                                        <h6 class="text-muted mb-0">@imdean</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        <img src="assets/images/faces/1.jpg">
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">John Dodol</h5>
                                        <h6 class="text-muted mb-0">@dodoljohn</h6>
                                    </div>
                                </div>
                                <div class="px-4">
                                    <button class="btn btn-block btn-xl btn-light-primary font-bold mt-3">Start
                                        Conversation</button>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h4>Visitors Profile</h4>
                            </div>
                            <div class="card-body" style="position: relative;">
                                <div id="chart-visitors-profile" style="min-height: 260.7px;"><div id="apexcharts6ngsfq29" class="apexcharts-canvas apexcharts6ngsfq29 apexcharts-theme-light" style="width: 252px; height: 260.7px;"><svg id="SvgjsSvg1637" width="252" height="260.7" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" class="apexcharts-svg" xmlns:data="ApexChartsNS" transform="translate(0, 0)" style="background: transparent;"><foreignObject x="0" y="0" width="252" height="260.7"><div class="apexcharts-legend apexcharts-align-center position-bottom" xmlns="http://www.w3.org/1999/xhtml" style="inset: auto 0px 1px; position: absolute; max-height: 175px;"><div class="apexcharts-legend-series" rel="1" seriesname="Male" data:collapsed="false" style="margin: 2px 5px;"><span class="apexcharts-legend-marker" rel="1" data:collapsed="false" style="background: rgb(67, 94, 190) !important; color: rgb(67, 94, 190); height: 12px; width: 12px; left: 0px; top: 0px; border-width: 0px; border-color: rgb(255, 255, 255); border-radius: 12px;"></span><span class="apexcharts-legend-text" rel="1" i="0" data:default-text="Male" data:collapsed="false" style="color: rgb(55, 61, 63); font-size: 12px; font-weight: 400; font-family: Helvetica, Arial, sans-serif;">Male</span></div><div class="apexcharts-legend-series" rel="2" seriesname="Female" data:collapsed="false" style="margin: 2px 5px;"><span class="apexcharts-legend-marker" rel="2" data:collapsed="false" style="background: rgb(85, 198, 232) !important; color: rgb(85, 198, 232); height: 12px; width: 12px; left: 0px; top: 0px; border-width: 0px; border-color: rgb(255, 255, 255); border-radius: 12px;"></span><span class="apexcharts-legend-text" rel="2" i="1" data:default-text="Female" data:collapsed="false" style="color: rgb(55, 61, 63); font-size: 12px; font-weight: 400; font-family: Helvetica, Arial, sans-serif;">Female</span></div></div><style type="text/css">	
    	
      .apexcharts-legend {	
        display: flex;	
        overflow: auto;	
        padding: 0 10px;	
      }	
      .apexcharts-legend.position-bottom, .apexcharts-legend.position-top {	
        flex-wrap: wrap	
      }	
      .apexcharts-legend.position-right, .apexcharts-legend.position-left {	
        flex-direction: column;	
        bottom: 0;	
      }	
      .apexcharts-legend.position-bottom.apexcharts-align-left, .apexcharts-legend.position-top.apexcharts-align-left, .apexcharts-legend.position-right, .apexcharts-legend.position-left {	
        justify-content: flex-start;	
      }	
      .apexcharts-legend.position-bottom.apexcharts-align-center, .apexcharts-legend.position-top.apexcharts-align-center {	
        justify-content: center;  	
      }	
      .apexcharts-legend.position-bottom.apexcharts-align-right, .apexcharts-legend.position-top.apexcharts-align-right {	
        justify-content: flex-end;	
      }	
      .apexcharts-legend-series {	
        cursor: pointer;	
        line-height: normal;	
      }	
      .apexcharts-legend.position-bottom .apexcharts-legend-series, .apexcharts-legend.position-top .apexcharts-legend-series{	
        display: flex;	
        align-items: center;	
      }	
      .apexcharts-legend-text {	
        position: relative;	
        font-size: 14px;	
      }	
      .apexcharts-legend-text *, .apexcharts-legend-marker * {	
        pointer-events: none;	
      }	
      .apexcharts-legend-marker {	
        position: relative;	
        display: inline-block;	
        cursor: pointer;	
        margin-right: 3px;	
        border-style: solid;
      }	
      	
      .apexcharts-legend.apexcharts-align-right .apexcharts-legend-series, .apexcharts-legend.apexcharts-align-left .apexcharts-legend-series{	
        display: inline-block;	
      }	
      .apexcharts-legend-series.apexcharts-no-click {	
        cursor: auto;	
      }	
      .apexcharts-legend .apexcharts-hidden-zero-series, .apexcharts-legend .apexcharts-hidden-null-series {	
        display: none !important;	
      }	
      .apexcharts-inactive-legend {	
        opacity: 0.45;	
      }</style></foreignObject><g id="SvgjsG1639" class="apexcharts-inner apexcharts-graphical" transform="translate(12, 0)"><defs id="SvgjsDefs1638"><clipPath id="gridRectMask6ngsfq29"><rect id="SvgjsRect1641" width="236" height="289" x="-3" y="-1" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath><clipPath id="gridRectMarkerMask6ngsfq29"><rect id="SvgjsRect1642" width="234" height="291" x="-2" y="-2" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath><filter id="SvgjsFilter1651" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feFlood id="SvgjsFeFlood1652" flood-color="#000000" flood-opacity="0.45" result="SvgjsFeFlood1652Out" in="SourceGraphic"></feFlood><feComposite id="SvgjsFeComposite1653" in="SvgjsFeFlood1652Out" in2="SourceAlpha" operator="in" result="SvgjsFeComposite1653Out"></feComposite><feOffset id="SvgjsFeOffset1654" dx="1" dy="1" result="SvgjsFeOffset1654Out" in="SvgjsFeComposite1653Out"></feOffset><feGaussianBlur id="SvgjsFeGaussianBlur1655" stdDeviation="1 " result="SvgjsFeGaussianBlur1655Out" in="SvgjsFeOffset1654Out"></feGaussianBlur><feMerge id="SvgjsFeMerge1656" result="SvgjsFeMerge1656Out" in="SourceGraphic"><feMergeNode id="SvgjsFeMergeNode1657" in="SvgjsFeGaussianBlur1655Out"></feMergeNode><feMergeNode id="SvgjsFeMergeNode1658" in="[object Arguments]"></feMergeNode></feMerge><feBlend id="SvgjsFeBlend1659" in="SourceGraphic" in2="SvgjsFeMerge1656Out" mode="normal" result="SvgjsFeBlend1659Out"></feBlend></filter><filter id="SvgjsFilter1664" filterUnits="userSpaceOnUse" width="200%" height="200%" x="-50%" y="-50%"><feFlood id="SvgjsFeFlood1665" flood-color="#000000" flood-opacity="0.45" result="SvgjsFeFlood1665Out" in="SourceGraphic"></feFlood><feComposite id="SvgjsFeComposite1666" in="SvgjsFeFlood1665Out" in2="SourceAlpha" operator="in" result="SvgjsFeComposite1666Out"></feComposite><feOffset id="SvgjsFeOffset1667" dx="1" dy="1" result="SvgjsFeOffset1667Out" in="SvgjsFeComposite1666Out"></feOffset><feGaussianBlur id="SvgjsFeGaussianBlur1668" stdDeviation="1 " result="SvgjsFeGaussianBlur1668Out" in="SvgjsFeOffset1667Out"></feGaussianBlur><feMerge id="SvgjsFeMerge1669" result="SvgjsFeMerge1669Out" in="SourceGraphic"><feMergeNode id="SvgjsFeMergeNode1670" in="SvgjsFeGaussianBlur1668Out"></feMergeNode><feMergeNode id="SvgjsFeMergeNode1671" in="[object Arguments]"></feMergeNode></feMerge><feBlend id="SvgjsFeBlend1672" in="SourceGraphic" in2="SvgjsFeMerge1669Out" mode="normal" result="SvgjsFeBlend1672Out"></feBlend></filter></defs><g id="SvgjsG1643" class="apexcharts-pie"><g id="SvgjsG1644" transform="translate(0, 0) scale(1)"><circle id="SvgjsCircle1645" r="31.858536585365854" cx="115" cy="115" fill="transparent"></circle><g id="SvgjsG1646" class="apexcharts-slices"><g id="SvgjsG1647" class="apexcharts-series apexcharts-pie-series" seriesName="Male" rel="1" data:realIndex="0"><path id="SvgjsPath1648" d="M 115 8.80487804878048 A 106.19512195121952 106.19512195121952 0 1 1 14.00243726953417 147.81609740264688 L 84.70073118086026 124.84482922079405 A 31.858536585365854 31.858536585365854 0 1 0 115 83.14146341463415 L 115 8.80487804878048 z" fill="rgba(67,94,190,1)" fill-opacity="1" stroke-opacity="1" stroke-linecap="butt" stroke-width="2" stroke-dasharray="0" class="apexcharts-pie-area apexcharts-donut-slice-0" index="0" j="0" data:angle="252" data:startAngle="0" data:strokeWidth="2" data:value="70" data:pathOrig="M 115 8.80487804878048 A 106.19512195121952 106.19512195121952 0 1 1 14.00243726953417 147.81609740264688 L 84.70073118086026 124.84482922079405 A 31.858536585365854 31.858536585365854 0 1 0 115 83.14146341463415 L 115 8.80487804878048 z" stroke="#ffffff"></path></g><g id="SvgjsG1660" class="apexcharts-series apexcharts-pie-series" seriesName="Female" rel="2" data:realIndex="1"><path id="SvgjsPath1661" d="M 14.00243726953417 147.81609740264688 A 106.19512195121952 106.19512195121952 0 0 1 114.98146545481802 8.804879666224679 L 114.9944396364454 83.1414638998674 A 31.858536585365854 31.858536585365854 0 0 0 84.70073118086026 124.84482922079405 L 14.00243726953417 147.81609740264688 z" fill="rgba(85,198,232,1)" fill-opacity="1" stroke-opacity="1" stroke-linecap="butt" stroke-width="2" stroke-dasharray="0" class="apexcharts-pie-area apexcharts-donut-slice-1" index="0" j="1" data:angle="108" data:startAngle="252" data:strokeWidth="2" data:value="30" data:pathOrig="M 14.00243726953417 147.81609740264688 A 106.19512195121952 106.19512195121952 0 0 1 114.98146545481802 8.804879666224679 L 114.9944396364454 83.1414638998674 A 31.858536585365854 31.858536585365854 0 0 0 84.70073118086026 124.84482922079405 L 14.00243726953417 147.81609740264688 z" stroke="#ffffff"></path></g><g id="SvgjsG1649" class="apexcharts-datalabels"><text id="SvgjsText1650" font-family="Helvetica, Arial, sans-serif" x="170.8438779458668" y="155.5729522564129" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-weight="600" fill="#ffffff" class="apexcharts-text apexcharts-pie-label" filter="url(#SvgjsFilter1651)" style="font-family: Helvetica, Arial, sans-serif;">70.0%</text></g><g id="SvgjsG1662" class="apexcharts-datalabels"><text id="SvgjsText1663" font-family="Helvetica, Arial, sans-serif" x="59.1561220541332" y="74.42704774358712" text-anchor="middle" dominant-baseline="auto" font-size="12px" font-weight="600" fill="#ffffff" class="apexcharts-text apexcharts-pie-label" filter="url(#SvgjsFilter1664)" style="font-family: Helvetica, Arial, sans-serif;">30.0%</text></g></g></g></g><line id="SvgjsLine1673" x1="0" y1="0" x2="230" y2="0" stroke="#b6b6b6" stroke-dasharray="0" stroke-width="1" class="apexcharts-ycrosshairs"></line><line id="SvgjsLine1674" x1="0" y1="0" x2="230" y2="0" stroke-dasharray="0" stroke-width="0" class="apexcharts-ycrosshairs-hidden"></line></g><g id="SvgjsG1640" class="apexcharts-annotations"></g></svg><div class="apexcharts-tooltip apexcharts-theme-dark"><div class="apexcharts-tooltip-series-group" style="order: 1;"><span class="apexcharts-tooltip-marker" style="background-color: rgb(67, 94, 190);"></span><div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"><div class="apexcharts-tooltip-y-group"><span class="apexcharts-tooltip-text-label"></span><span class="apexcharts-tooltip-text-value"></span></div><div class="apexcharts-tooltip-z-group"><span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span></div></div></div><div class="apexcharts-tooltip-series-group" style="order: 2;"><span class="apexcharts-tooltip-marker" style="background-color: rgb(85, 198, 232);"></span><div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"><div class="apexcharts-tooltip-y-group"><span class="apexcharts-tooltip-text-label"></span><span class="apexcharts-tooltip-text-value"></span></div><div class="apexcharts-tooltip-z-group"><span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span></div></div></div></div></div></div>
                            <div class="resize-triggers"><div class="expand-trigger"><div style="width: 301px; height: 286px;"></div></div><div class="contract-trigger"></div></div></div>
                        </div>
                    </div>
                </section>
            </div>

        </div>




</body>

</html>