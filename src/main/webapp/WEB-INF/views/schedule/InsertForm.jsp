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
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>TinyMCE</h3>
						<p class="text-subtitle text-muted">Super simple WYSIWYG
							editor. But you must include jQuery</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">TinyMCE</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">Default Editor</h4>
							</div>
							<div class="card-body">
								<textarea name="" id="default" cols="30" rows="10"
									aria-hidden="true" style="display: none;"></textarea>
								<div role="application" class="tox tox-tinymce"
									aria-disabled="false"
									style="visibility: hidden; height: 246px;">
									<div class="tox-editor-container">
										<div data-alloy-vertical-dir="toptobottom"
											class="tox-editor-header">
											<div role="menubar" data-alloy-tabstop="true"
												class="tox-menubar">
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">File</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">Edit</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">View</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">Format</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
											</div>
											<div role="group" class="tox-toolbar-overlord"
												aria-disabled="false">
												<div role="group" class="tox-toolbar__primary">
													<div title="history" role="toolbar"
														data-alloy-tabstop="true" tabindex="-1"
														class="tox-toolbar__group">
														<button aria-label="Undo" title="Undo" type="button"
															tabindex="-1" class="tox-tbtn tox-tbtn--disabled"
															aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M6.4 8H12c3.7 0 6.2 2 6.8 5.1.6 2.7-.4 5.6-2.3 6.8a1 1 0 01-1-1.8c1.1-.6 1.8-2.7 1.4-4.6-.5-2.1-2.1-3.5-4.9-3.5H6.4l3.3 3.3a1 1 0 11-1.4 1.4l-5-5a1 1 0 010-1.4l5-5a1 1 0 011.4 1.4L6.4 8z"
																		fill-rule="nonzero"></path></svg></span>
														</button>
														<button aria-label="Redo" title="Redo" type="button"
															tabindex="-1" class="tox-tbtn tox-tbtn--disabled"
															aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M17.6 10H12c-2.8 0-4.4 1.4-4.9 3.5-.4 2 .3 4 1.4 4.6a1 1 0 11-1 1.8c-2-1.2-2.9-4.1-2.3-6.8.6-3 3-5.1 6.8-5.1h5.6l-3.3-3.3a1 1 0 111.4-1.4l5 5a1 1 0 010 1.4l-5 5a1 1 0 01-1.4-1.4l3.3-3.3z"
																		fill-rule="nonzero"></path></svg></span>
														</button>
													</div>
													<div title="styles" role="toolbar"
														data-alloy-tabstop="true" tabindex="-1"
														class="tox-toolbar__group">
														<button title="Formats" aria-label="Formats"
															aria-haspopup="true" type="button" unselectable="on"
															tabindex="-1"
															class="tox-tbtn tox-tbtn--select tox-tbtn--bespoke"
															aria-expanded="false" style="user-select: none;">
															<span class="tox-tbtn__select-label">Paragraph</span>
															<div class="tox-tbtn__select-chevron">
																<svg width="10" height="10">
																	<path
																		d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																		fill-rule="nonzero"></path></svg>
															</div>
														</button>
													</div>
													<div title="formatting" role="toolbar"
														data-alloy-tabstop="true" tabindex="-1"
														class="tox-toolbar__group">
														<button aria-label="Bold" title="Bold" type="button"
															tabindex="-1" class="tox-tbtn" aria-disabled="false"
															aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7.8 19c-.3 0-.5 0-.6-.2l-.2-.5V5.7c0-.2 0-.4.2-.5l.6-.2h5c1.5 0 2.7.3 3.5 1 .7.6 1.1 1.4 1.1 2.5a3 3 0 01-.6 1.9c-.4.6-1 1-1.6 1.2.4.1.9.3 1.3.6s.8.7 1 1.2c.4.4.5 1 .5 1.6 0 1.3-.4 2.3-1.3 3-.8.7-2.1 1-3.8 1H7.8zm5-8.3c.6 0 1.2-.1 1.6-.5.4-.3.6-.7.6-1.3 0-1.1-.8-1.7-2.3-1.7H9.3v3.5h3.4zm.5 6c.7 0 1.3-.1 1.7-.4.4-.4.6-.9.6-1.5s-.2-1-.7-1.4c-.4-.3-1-.4-2-.4H9.4v3.8h4z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Italic" title="Italic" type="button"
															tabindex="-1" class="tox-tbtn" aria-disabled="false"
															aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M16.7 4.7l-.1.9h-.3c-.6 0-1 0-1.4.3-.3.3-.4.6-.5 1.1l-2.1 9.8v.6c0 .5.4.8 1.4.8h.2l-.2.8H8l.2-.8h.2c1.1 0 1.8-.5 2-1.5l2-9.8.1-.5c0-.6-.4-.8-1.4-.8h-.3l.2-.9h5.8z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
													</div>
													<div title="alignment" role="toolbar"
														data-alloy-tabstop="true" tabindex="-1"
														class="tox-toolbar__group">
														<button aria-label="Align left" title="Align left"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 4h8c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2zm0-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Align center" title="Align center"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm3 4h8c.6 0 1 .4 1 1s-.4 1-1 1H8a1 1 0 110-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1H8a1 1 0 010-2zm-3-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Align right" title="Align right"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm6 4h8c.6 0 1 .4 1 1s-.4 1-1 1h-8a1 1 0 010-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1h-8a1 1 0 010-2zm-6-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Justify" title="Justify" type="button"
															tabindex="-1" class="tox-tbtn" aria-disabled="false"
															aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2zm0 4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
													</div>
													<div title="indentation" role="toolbar"
														data-alloy-tabstop="true" tabindex="-1"
														class="tox-toolbar__group">
														<button aria-label="Decrease indent"
															title="Decrease indent" type="button" tabindex="-1"
															class="tox-tbtn tox-tbtn--disabled" aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7 5h12c.6 0 1 .4 1 1s-.4 1-1 1H7a1 1 0 110-2zm5 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm0 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm-5 4h12a1 1 0 010 2H7a1 1 0 010-2zm1.6-3.8a1 1 0 01-1.2 1.6l-3-2a1 1 0 010-1.6l3-2a1 1 0 011.2 1.6L6.8 12l1.8 1.2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Increase indent"
															title="Increase indent" type="button" tabindex="-1"
															class="tox-tbtn" aria-disabled="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7 5h12c.6 0 1 .4 1 1s-.4 1-1 1H7a1 1 0 110-2zm5 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm0 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm-5 4h12a1 1 0 010 2H7a1 1 0 010-2zm-2.6-3.8L6.2 12l-1.8-1.2a1 1 0 011.2-1.6l3 2a1 1 0 010 1.6l-3 2a1 1 0 11-1.2-1.6z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
													</div>
												</div>
											</div>
											<div class="tox-anchorbar"></div>
										</div>
										<div class="tox-sidebar-wrap">
											<div class="tox-edit-area">
												<iframe id="default_ifr" frameborder="0"
													allowtransparency="true"
													title="Rich Text Area. Press ALT-0 for help."
													class="tox-edit-area__iframe"></iframe>
											</div>
											<div role="complementary" class="tox-sidebar">
												<div data-alloy-tabstop="true" tabindex="-1"
													class="tox-sidebar__slider tox-sidebar--sliding-closed"
													style="width: 0px;">
													<div class="tox-sidebar__pane-container"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="tox-statusbar">
										<div class="tox-statusbar__text-container">
											<div role="navigation" data-alloy-tabstop="true"
												class="tox-statusbar__path" aria-disabled="false">
												<div role="button" data-index="0" tab-index="-1"
													aria-level="1" tabindex="-1"
													class="tox-statusbar__path-item" aria-disabled="false">p</div>
											</div>
											<span class="tox-statusbar__branding"><a
												href="https://www.tiny.cloud/?utm_campaign=editor_referral&amp;utm_medium=poweredby&amp;utm_source=tinymce&amp;utm_content=v5"
												rel="noopener" target="_blank" tabindex="-1"
												aria-label="Powered by Tiny">Powered by Tiny</a></span>
										</div>
										<div title="Resize" aria-hidden="true"
											class="tox-statusbar__resize-handle">
											<svg width="10" height="10">
												<g fill-rule="nonzero">
												<path
													d="M8.1 1.1A.5.5 0 119 2l-7 7A.5.5 0 111 8l7-7zM8.1 5.1A.5.5 0 119 6l-3 3A.5.5 0 115 8l3-3z"></path></g></svg>
										</div>
									</div>
									<div aria-hidden="true" class="tox-throbber"
										style="display: none;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">Code Toolbar</h4>
							</div>
							<div class="card-body">
								<textarea id="dark" cols="30" rows="10" aria-hidden="true"
									style="display: none;"></textarea>
								<div role="application" class="tox tox-tinymce"
									aria-disabled="false"
									style="visibility: hidden; height: 246px;">
									<div class="tox-editor-container">
										<div data-alloy-vertical-dir="toptobottom"
											class="tox-editor-header">
											<div role="menubar" data-alloy-tabstop="true"
												class="tox-menubar">
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">File</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">Edit</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">View</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">Format</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
												<button aria-haspopup="true" role="menuitem" type="button"
													data-alloy-tabstop="true" unselectable="on" tabindex="-1"
													class="tox-mbtn tox-mbtn--select" aria-expanded="false"
													style="user-select: none;">
													<span class="tox-mbtn__select-label">Tools</span>
													<div class="tox-mbtn__select-chevron">
														<svg width="10" height="10">
															<path
																d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																fill-rule="nonzero"></path></svg>
													</div>
												</button>
											</div>
											<div role="group" class="tox-toolbar-overlord"
												aria-disabled="false">
												<div role="group" class="tox-toolbar__primary">
													<div title="" role="toolbar" data-alloy-tabstop="true"
														tabindex="-1" class="tox-toolbar__group">
														<button aria-label="Undo" title="Undo" type="button"
															tabindex="-1" class="tox-tbtn tox-tbtn--disabled"
															aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M6.4 8H12c3.7 0 6.2 2 6.8 5.1.6 2.7-.4 5.6-2.3 6.8a1 1 0 01-1-1.8c1.1-.6 1.8-2.7 1.4-4.6-.5-2.1-2.1-3.5-4.9-3.5H6.4l3.3 3.3a1 1 0 11-1.4 1.4l-5-5a1 1 0 010-1.4l5-5a1 1 0 011.4 1.4L6.4 8z"
																		fill-rule="nonzero"></path></svg></span>
														</button>
														<button aria-label="Redo" title="Redo" type="button"
															tabindex="-1" class="tox-tbtn tox-tbtn--disabled"
															aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M17.6 10H12c-2.8 0-4.4 1.4-4.9 3.5-.4 2 .3 4 1.4 4.6a1 1 0 11-1 1.8c-2-1.2-2.9-4.1-2.3-6.8.6-3 3-5.1 6.8-5.1h5.6l-3.3-3.3a1 1 0 111.4-1.4l5 5a1 1 0 010 1.4l-5 5a1 1 0 01-1.4-1.4l3.3-3.3z"
																		fill-rule="nonzero"></path></svg></span>
														</button>
														<button title="Formats" aria-label="Formats"
															aria-haspopup="true" type="button" unselectable="on"
															tabindex="-1"
															class="tox-tbtn tox-tbtn--select tox-tbtn--bespoke"
															aria-expanded="false" style="user-select: none;">
															<span class="tox-tbtn__select-label">Paragraph</span>
															<div class="tox-tbtn__select-chevron">
																<svg width="10" height="10">
																	<path
																		d="M8.7 2.2c.3-.3.8-.3 1 0 .4.4.4.9 0 1.2L5.7 7.8c-.3.3-.9.3-1.2 0L.2 3.4a.8.8 0 010-1.2c.3-.3.8-.3 1.1 0L5 6l3.7-3.8z"
																		fill-rule="nonzero"></path></svg>
															</div>
														</button>
														<button aria-label="Bold" title="Bold" type="button"
															tabindex="-1" class="tox-tbtn" aria-disabled="false"
															aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7.8 19c-.3 0-.5 0-.6-.2l-.2-.5V5.7c0-.2 0-.4.2-.5l.6-.2h5c1.5 0 2.7.3 3.5 1 .7.6 1.1 1.4 1.1 2.5a3 3 0 01-.6 1.9c-.4.6-1 1-1.6 1.2.4.1.9.3 1.3.6s.8.7 1 1.2c.4.4.5 1 .5 1.6 0 1.3-.4 2.3-1.3 3-.8.7-2.1 1-3.8 1H7.8zm5-8.3c.6 0 1.2-.1 1.6-.5.4-.3.6-.7.6-1.3 0-1.1-.8-1.7-2.3-1.7H9.3v3.5h3.4zm.5 6c.7 0 1.3-.1 1.7-.4.4-.4.6-.9.6-1.5s-.2-1-.7-1.4c-.4-.3-1-.4-2-.4H9.4v3.8h4z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Italic" title="Italic" type="button"
															tabindex="-1" class="tox-tbtn" aria-disabled="false"
															aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M16.7 4.7l-.1.9h-.3c-.6 0-1 0-1.4.3-.3.3-.4.6-.5 1.1l-2.1 9.8v.6c0 .5.4.8 1.4.8h.2l-.2.8H8l.2-.8h.2c1.1 0 1.8-.5 2-1.5l2-9.8.1-.5c0-.6-.4-.8-1.4-.8h-.3l.2-.9h5.8z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Align left" title="Align left"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 4h8c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2zm0-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Align center" title="Align center"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm3 4h8c.6 0 1 .4 1 1s-.4 1-1 1H8a1 1 0 110-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1H8a1 1 0 010-2zm-3-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Align right" title="Align right"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false" aria-pressed="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M5 5h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 110-2zm6 4h8c.6 0 1 .4 1 1s-.4 1-1 1h-8a1 1 0 010-2zm0 8h8c.6 0 1 .4 1 1s-.4 1-1 1h-8a1 1 0 010-2zm-6-4h14c.6 0 1 .4 1 1s-.4 1-1 1H5a1 1 0 010-2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Decrease indent"
															title="Decrease indent" type="button" tabindex="-1"
															class="tox-tbtn tox-tbtn--disabled" aria-disabled="true">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7 5h12c.6 0 1 .4 1 1s-.4 1-1 1H7a1 1 0 110-2zm5 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm0 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm-5 4h12a1 1 0 010 2H7a1 1 0 010-2zm1.6-3.8a1 1 0 01-1.2 1.6l-3-2a1 1 0 010-1.6l3-2a1 1 0 011.2 1.6L6.8 12l1.8 1.2z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Increase indent"
															title="Increase indent" type="button" tabindex="-1"
															class="tox-tbtn" aria-disabled="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<path
																		d="M7 5h12c.6 0 1 .4 1 1s-.4 1-1 1H7a1 1 0 110-2zm5 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm0 4h7c.6 0 1 .4 1 1s-.4 1-1 1h-7a1 1 0 010-2zm-5 4h12a1 1 0 010 2H7a1 1 0 010-2zm-2.6-3.8L6.2 12l-1.8-1.2a1 1 0 011.2-1.6l3 2a1 1 0 010 1.6l-3 2a1 1 0 11-1.2-1.6z"
																		fill-rule="evenodd"></path></svg></span>
														</button>
														<button aria-label="Source code" title="Source code"
															type="button" tabindex="-1" class="tox-tbtn"
															aria-disabled="false">
															<span class="tox-icon tox-tbtn__icon-wrap"><svg
																	width="24" height="24">
																	<g fill-rule="nonzero">
																	<path
																		d="M9.8 15.7c.3.3.3.8 0 1-.3.4-.9.4-1.2 0l-4.4-4.1a.8.8 0 010-1.2l4.4-4.2c.3-.3.9-.3 1.2 0 .3.3.3.8 0 1.1L6 12l3.8 3.7zM14.2 15.7c-.3.3-.3.8 0 1 .4.4.9.4 1.2 0l4.4-4.1c.3-.3.3-.9 0-1.2l-4.4-4.2a.8.8 0 00-1.2 0c-.3.3-.3.8 0 1.1L18 12l-3.8 3.7z"></path></g></svg></span>
														</button>
													</div>
												</div>
											</div>
											<div class="tox-anchorbar"></div>
										</div>
										<div class="tox-sidebar-wrap">
											<div class="tox-edit-area">
												<iframe id="dark_ifr" frameborder="0"
													allowtransparency="true"
													title="Rich Text Area. Press ALT-0 for help."
													class="tox-edit-area__iframe"></iframe>
											</div>
											<div role="complementary" class="tox-sidebar">
												<div data-alloy-tabstop="true" tabindex="-1"
													class="tox-sidebar__slider tox-sidebar--sliding-closed"
													style="width: 0px;">
													<div class="tox-sidebar__pane-container"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="tox-statusbar">
										<div class="tox-statusbar__text-container">
											<div role="navigation" data-alloy-tabstop="true"
												class="tox-statusbar__path" aria-disabled="false">
												<div role="button" data-index="0" tab-index="-1"
													aria-level="1" tabindex="-1"
													class="tox-statusbar__path-item" aria-disabled="false">p</div>
											</div>
											<span class="tox-statusbar__branding"><a
												href="https://www.tiny.cloud/?utm_campaign=editor_referral&amp;utm_medium=poweredby&amp;utm_source=tinymce&amp;utm_content=v5"
												rel="noopener" target="_blank" tabindex="-1"
												aria-label="Powered by Tiny">Powered by Tiny</a></span>
										</div>
										<div title="Resize" aria-hidden="true"
											class="tox-statusbar__resize-handle">
											<svg width="10" height="10">
												<g fill-rule="nonzero">
												<path
													d="M8.1 1.1A.5.5 0 119 2l-7 7A.5.5 0 111 8l7-7zM8.1 5.1A.5.5 0 119 6l-3 3A.5.5 0 115 8l3-3z"></path></g></svg>
										</div>
									</div>
									<div aria-hidden="true" class="tox-throbber"
										style="display: none;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

	</div>


</body>
</html>