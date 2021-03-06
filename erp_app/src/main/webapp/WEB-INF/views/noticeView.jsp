<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<body>
	<!--header start-->

	<jsp:include page="header.jsp"></jsp:include>

	<!--header end-->

	<!--sidebar end-->

	<!-- **********************************************************************************************************************************************************
        	MAIN CONTENT
       	 *********************************************************************************************************************************************************** -->
	<!--main content start-->
	<section id="main-content">
		<section class="wrapper">
			<div class="content-panel">
				<h4>
					<i class="fa fa-angle-right"></i>Support
				</h4>
				<hr>

				<section class="panel">
					<div class="panel-body ">
						<div class="mail-header row">
							<div class="col-md-8">
								<h4 class="pull-left">${noticeView.subject}</h4>
							</div>
							<div class="col-md-4">
								<div class="compose-btn pull-right">
									<button class="btn  btn-sm tooltips" data-original-title="Edit"
										type="button" data-toggle="tooltip" data-placement="top"
										title="" onclick="location.href='/noticeEdit?no='+${noticeView.no}">
										<i class="fa fa-edit"></i>
									</button>
									<button class="btn btn-sm tooltips" data-original-title="Trash"
										data-toggle="tooltip" data-placement="top" title="" onclick="notice_delete()" >
										<i class="fa fa-trash-o"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="mail-sender">
							<div class="row">
								<div class="col-md-8">
									<strong>${noticeView.name}</strong>
								</div>
								<div class="col-md-4">
									<p class="date">${noticeView.make_date}</p>
								</div>
								<div class="col-md-4">
									<p class="count">views: ${noticeView.view_count}</p>
								</div>
							</div>
						</div>
						<div class="view-mail">
							<p>${noticeView.contents}</p>
						</div>
					</div>
				</section>

				<div class="chat-room mt" id=reqWin>
					<aside class="mid-side">
						<div class="chat-room-head">
							<h3>comment</h3>
						</div>
						<div class="group-rom">
 							<INPUT TYPE="hidden" NAME="session_id" id="session_id" VALUE="${sessionScope.LoginInfo.no}"/>
							<INPUT TYPE="hidden" NAME="no" id="no" VALUE="${noticeView.no}"/> 
							<input type="hidden" value="${list.reply_no}" id="reply_no" NAME="reply_no"> 
							<c:forEach items="${noticeReqView}" var="list">	
								<%-- <INPUT TYPE="hidden" NAME="member_no" id="member_no" VALUE="${list.req_memberNo}"/> --%>
								<div class="first-part odd" id="req_name">${list.req_name}</div>
								<div class="second-part" id="req_contentsList" >${list.req_contents}
								<c:if test="${sessionScope.LoginInfo.no eq list.req_memberNo}">
								<button type="button" class="btn btn-white" onclick="req_update(${list.reply_no});">
									??????
								</button>
								<button type="button" class="btn btn-white" onclick="req_delete(this);">
									??????</i>
								</button>																	
								</c:if>
								</div>
								
								<div class="third-part" id="req_makeDate" >${list.req_makeDate}</div>
							</c:forEach>
						</div>
						<div class="chat-txt">
								<input type="text" class="form-control" id="req_contents">
							</div>

							<button class="btn btn-theme" onclick="send();" >Send</button>
					</aside>
				</div>
			</div>

		</section>
	</section>
	<!--main content end-->
	<!--footer start-->
	<jsp:include page="footer.jsp"></jsp:include>

	<!--footer end-->
</body>
<script type="text/javascript">
$(document).ready(function() {
	var update_check =false;

 })
 
 //?????? ??????
 function send(){
 	var reply_no=$('#reply_no').val(); 
 	alert("send"+reply_no+ "update_check"+update_check);
 	if(update_check!=true){
 		document.getElementById("reply_no").value=-1;
	}   
 	
	$.ajax({
        url: "noticeReqSend",
        type: "POST",
        data: {
				"no" : $("#no").val(),
				"member_no" : $("#session_id").val(),
				"req_contents" : $("#req_contents").val(),
				"reply_no" : $("#reply_no").val()
			},
        success: function(data){
        	$('#reqWin').load(document.URL +  ' #reqWin');
        },
        error: function(){
            alert("An error occurred. please try again.");
        }
    }); 
	}

//?????? ????????????
function req_update(reply_no){
	document.getElementById("reply_no").value=reply_no; 
	update_check= true;
	$('#req_contents').focus();
}

//?????? ??????
function req_delete(){
	if(!confirm("?????????????????????????")){
		return 0;
	}
 	 $.ajax({
        url: "noticeReqDelete",
        type: "POST",
        data: {
				"no" : $("#no").val(),
				"reply_no" : $("#reply_no").val() ,
				"member_no" : $("#session_id").val(),
				
			},
        success: function(data){
        	 location.reload();
        },
        error: function(){
            alert("????????? ?????????????????????.");
        }
    });   
}
	
//??? ??????
function notice_delete(){
	var session_id=$("#session_id").val();
	var no=$("#no").val();
	
	if(!confirm("?????????????????????????")){
		return 0;
	}
	
	location.href = "/noticeDelete?no=" + no +"&member_no="+ session_id;
	
}
</script>

</html>
