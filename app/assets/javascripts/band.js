$(function(){

checkForDuplicate();

});


function checkForDuplicate() {
	$(".new_band").on("submit", function(e){
		e.preventDefault();
		e.stopPropagation();
		var $formVal = $(".band-name").val();
		var $ulVal = $(".band-list").html();
		if (($ulVal.indexOf($formVal)) >= 0) {
			$("#duplication-alert").removeClass("hidden-alert");
		}else {
			$("#duplication-alert").addClass("hidden-alert");
			 var $form = $(this);
			 submitBand($form);
		}
	});
}

function submitBand(form) {
	var data = form.serialize();
	var url = form.attr("action");
	var method = form.attr("method");

	$.ajax(url, {
		method: method,
		data: data,
		success: function(response) {
			debugger;
			$('ul.band-list').prepend(response);
			$('.band-name').val("");
		}
	});
}






