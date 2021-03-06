<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>My Tour ::</title>

<!-- Favicons -->
<link href="resources/img/favicon.png" rel="icon">
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="resources/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="resources/lib/bootstrap-fileupload/bootstrap-fileupload.css" />
<link rel="stylesheet" type="text/css" href="resources/lib/bootstrap-datepicker/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="resources/lib/bootstrap-daterangepicker/daterangepicker.css" />
<link rel="stylesheet" type="text/css" href="resources/lib/bootstrap-timepicker/compiled/timepicker.css" />
<!-- Custom styles for this template -->
<link href="resources/css/style.css" rel="stylesheet">
<link href="resources/css/style-responsive.css" rel="stylesheet">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var check = false;

	function id_check() {

		var id = $("#id").val();

		if (id == "" || id == null) {
			alert("please enter you ID");
			return;
		}

		$.ajax({
			url : "ex/idCheck",
			type : "post",
			async : false,
			data : id,
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				if (!data.result) {
					alert("ID already exists.");
					return;
				} else {
					alert("ID is available.");
					check = true;
					return;
				}
			},
			error : function() {
				alert("An error occurred. please try again.");
			}

		});

	}

	function join() {

		//- ????????? ??????
		if (!check) {
			alert("Please double check ID");
			return;
		}

		var pw1 = $("#password").val();
		var pw2 = $("#confirm_password").val();
		if (pw1 != pw2) {
			alert("Passwords are not the same.");
			return;
		}

		$.ajax({
			url : "ex/RegisterMember",
			type : "post",
			async : false,
			data : {
				"Id" : $("#id").val(),
				"Password" : $("#confirm_password").val(),
				"Name" : $("#username").val(),
				"Email" : $("#email").val(),
				"Phone" : $("#phone").val(),
				"Birth" : $("#birthDate").val(),
				"ZipCode" : $("#zipCode").val(),
				"Address1" : $("#address1").val(),
				"Address2" : $("#address2").val(),
				"Gender" : $('input[name="gender"]:checked').val(),

			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("You have been registered successfully");
					window.signupForm.submit();
				}
			},
			error : function() {
				alert("An error occurred. please try again.");
			}

		});

	}

	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.

						// ??? ????????? ?????? ????????? ?????? ????????? ????????????.
						// ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
						var fullAddr = ''; // ?????? ?????? ??????
						var extraAddr = ''; // ????????? ?????? ??????

						// ???????????? ????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????????.
						if (data.userSelectedType === 'R') { // ???????????? ????????? ????????? ???????????? ??????
							fullAddr = data.roadAddress;

						} else { // ???????????? ?????? ????????? ???????????? ??????(J)
							fullAddr = data.jibunAddress;
						}

						// ???????????? ????????? ????????? ????????? ???????????? ????????????.
						if (data.userSelectedType === 'R') {
							//??????????????? ?????? ?????? ????????????.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// ???????????? ?????? ?????? ????????????.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// ?????????????????? ????????? ?????? ????????? ????????? ???????????? ?????? ????????? ?????????.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// ??????????????? ?????? ????????? ?????? ????????? ?????????.
						document.getElementById('zipCode').value = data.zonecode; //5?????? ??????????????? ??????
						document.getElementById('address1').value = fullAddr;

						// ????????? ???????????? ????????? ????????????.
						document.getElementById('address2').focus();
					}
				}).open();
	}
</script>
</head>
<body>


	<!--sidebar end-->

	<!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
	<!--main content start-->
	<section class="wrapper" style="margin-top: 0px;">
		<h3>
			<i class="fa fa-angle-right"></i> Sign up
		</h3>
		<!-- BASIC FORM VALIDATION -->
		<!-- /row -->
		<div class="row mt">
			<div class="col-lg-12">
				<div class="form-panel">
					<div class="form">
						<form class="cmxform form-horizontal style-form" id="signupForm" onsubmit="return false;" method="post" action="/">
							<div class="form-group ">
								<label for="id" class="control-label col-lg-2">ID</label>
								<div class="col-lg-10">
									<input class=" form-control" style="width: 30%; display: inline" id="id" name="id" type="text"> <input type="button" class="btn btn-theme04" onclick="id_check();" value="Please double check ID">
								</div>
							</div>
							<div class="form-group " style="">
								<label for="password" class="control-label col-lg-2">Password</label>
								<div class="col-lg-10">
									<input class="form-control " style="width: 30%;" id="password" name="password" type="password">
								</div>
							</div>
							<div class="form-group " style="">
								<label for="confirm_password" class="control-label col-lg-2">Confirm password</label>
								<div class="col-lg-10">
									<input class="form-control " style="width: 30%;" id="confirm_password" name="confirm_password" type="password">
								</div>
							</div>
							<div class="form-group ">
								<label for="username" class="control-label col-lg-2">Name</label>
								<div class="col-lg-10">
									<input class="form-control " style="width: 30%;" id="username" name="username" type="text">
								</div>
							</div>

							<div class="form-group ">
								<label for="email" class="control-label col-lg-2">E-mail</label>
								<div class="col-lg-10">
									<input class="form-control " style="width: 30%;" id="email" name="email" type="email">
								</div>
							</div>

							<div class="form-group ">
								<label for="phone" class="control-label col-lg-2">Phone</label>
								<div class="col-lg-10">
									<input class="form-control " style="width: 30%;" id="phone" name="phone" type="text" placeholder="010-0000-0000">
								</div>
							</div>

							<div class="form-group" class="col-lg-12">
								<label for="birthDate" class="control-label col-lg-2">Birth</label>
								<div class="col-md-3 col-xs-11">
									<div data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="2018-01-01" class="input-append date dpYears">
										<input type="text" id="birthDate" value="2018-01-01" size="16" class="form-control" readonly /> <span class="input-group-btn add-on">
											<button class="btn btn-theme" type="button">
												<i class="fa fa-calendar"></i>
											</button>
										</span>
									</div>
								</div>
							</div>

							<div class="form-group ">
								<label for="gender" class="control-label col-lg-2 col-sm-3">Gender</label>
								<div class="col-lg-10 col-sm-9">
									<input type="radio" name="gender" value="M" /> Male <input type="radio" name="gender" value="F" checked="checked" /> Female
								</div>
							</div>

							<div class="form-group">
								<label for="addr" class="control-label col-lg-2 col-sm-3">Address</label> 
								<input class="form-control " style="width: 20%; display: inline" type="text" id="zipCode" placeholder="ZipCode" readOnly /> 
								<input type="button" class="btn btn-theme" onclick="sample6_execDaumPostcode()" value="Find zipCode"><br> 
								<label for="addr" class="control-label col-lg-2 col-sm-3"></label>
								<div style="margin-top: 3px;">
									<input class="form-control " style="width: 25%; display: inline-block" type="text" id="address1" placeholder="Address" readOnly> 
									<input class="form-control " style="width: 25%; display: inline-block" type="text" id="address2" placeholder="Detailed Address">
								</div>
							</div>

							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<button class="btn btn-theme" type="submit" onclick="join();">Sign up</button>
									<button class="btn btn-theme04" type="button" onclick="location.href='/'">Cancel</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- /form-panel -->
			</div>
			<!-- /col-lg-12 -->
		</div>
		<!-- /row -->
	</section>
	<!--main content end-->

	<!-- js placed at the end of the document so the pages load faster -->
	<script src="resources/lib/jquery/jquery.min.js"></script>
	<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="resources/lib/jquery.dcjqaccordion.2.7.js"></script>
	<script src="resources/lib/jquery.scrollTo.min.js"></script>
	<script src="resources/lib/jquery.nicescroll.js" type="text/javascript"></script>
	<!--common script for all pages-->
	<script src="resources/lib/common-scripts.js"></script>
	<!--script for this page-->
	<script src="resources/lib/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-fileupload/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-daterangepicker/moment.min.js"></script>
	<script type="text/javascript" src="resources/lib/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script src="resources/lib/advanced-form-components.js"></script>

</body>

</html>

