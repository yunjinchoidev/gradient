<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Rating - Mazer Admin Dashboard</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>


<body>
	<div class="col-md-6 mb-4">
		<h6>Basic Choices</h6>
		<p>
			Use
			<code>.choices</code>
			class for basic choices control.
		</p>
		<div class="form-group">
			<div class="choices" data-type="select-one" tabindex="0"
				role="combobox" aria-autocomplete="list" aria-haspopup="true"
				aria-expanded="false">
				<div class="choices__inner">
					<select class="choices form-select choices__input" hidden=""
						tabindex="-1" data-choice="active"><option value="square">Square</option></select>
					<div class="choices__list choices__list--single">
						<div class="choices__item choices__item--selectable" data-item=""
							data-id="1" data-value="square" data-custom-properties="null"
							aria-selected="true">Square</div>
					</div>
				</div>
				<div class="choices__list choices__list--dropdown"
					aria-expanded="false">
					<input type="text" class="choices__input choices__input--cloned"
						autocomplete="off" autocapitalize="off" spellcheck="false"
						role="textbox" aria-autocomplete="list" aria-label="false"
						placeholder="">
					<div class="choices__list" role="listbox">
						<div id="choices--bo16-item-choice-1"
							class="choices__item choices__item--choice choices__item--selectable is-highlighted"
							role="option" data-choice="" data-id="1" data-value="polygon"
							data-select-text="Press to select" data-choice-selectable=""
							aria-selected="true">Polygon</div>
						<div id="choices--bo16-item-choice-2"
							class="choices__item choices__item--choice choices__item--selectable"
							role="option" data-choice="" data-id="2" data-value="rectangle"
							data-select-text="Press to select" data-choice-selectable="">Rectangle</div>
						<div id="choices--bo16-item-choice-3"
							class="choices__item choices__item--choice choices__item--selectable"
							role="option" data-choice="" data-id="3" data-value="rombo"
							data-select-text="Press to select" data-choice-selectable="">Rombo</div>
						<div id="choices--bo16-item-choice-4"
							class="choices__item choices__item--choice choices__item--selectable"
							role="option" data-choice="" data-id="4" data-value="romboid"
							data-select-text="Press to select" data-choice-selectable="">Romboid</div>
						<div id="choices--bo16-item-choice-5"
							class="choices__item choices__item--choice is-selected choices__item--selectable"
							role="option" data-choice="" data-id="5" data-value="square"
							data-select-text="Press to select" data-choice-selectable="">Square</div>
						<div id="choices--bo16-item-choice-6"
							class="choices__item choices__item--choice choices__item--selectable"
							role="option" data-choice="" data-id="6" data-value="trapeze"
							data-select-text="Press to select" data-choice-selectable="">Trapeze</div>
						<div id="choices--bo16-item-choice-7"
							class="choices__item choices__item--choice choices__item--selectable"
							role="option" data-choice="" data-id="7" data-value="traible"
							data-select-text="Press to select" data-choice-selectable="">Triangle</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>

<script
	src="/project5/resources/dist/assets/vendors/rater-js/rater-js.js"></script>
<script src="/project5/resources/dist/assets/js/extensions/rater-js.js"></script>

<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>