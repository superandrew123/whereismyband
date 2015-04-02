
$(function(){
	checkForDuplicate();
	//in event.js
	showEventsForBands();
});

// Check if a band has already been added to a user account
function checkForDuplicate() {
	$(".new_band").on("submit", function(e){
		e.preventDefault();
		e.stopPropagation();
		var $formVal = $(".band-name").val().toLowerCase();
		var $ulVal = $(".band-list").html();
		var $form = $(this);
		if ($ulVal != undefined){
			$ulVal = $(".band-list").html().toLowerCase();
			if (($ulVal.indexOf($formVal)) >= 0) {
       // // debugger;
				$("#duplication-alert").removeClass("hidden-alert");
				artistFound();
			} else {
				$("#duplication-alert").addClass("hidden-alert");
				artistFound();
				submitBand($form);
			}
		} else {
			submitBand($form);
		}
	});
}

// If no band conflicts, submit form
function submitBand(form) {
	var data = form.serialize();
	var url = form.attr("action");
	var method = form.attr("method");
	console.log("hi from submitBand");
	$.ajax(url, {
		method: method,
		data: data,
		success: function(response) {
			$('ul.band-list').prepend(response);
			$('.band-name').val("");
		}
	});
}

// Display artist not found error
function artistNotFound(){
	$("#unfound-artist-alert").removeClass("hidden-alert");
}

// Hide artist not found error
function artistFound(){
	$("#unfound-artist-alert").addClass("hidden-alert");
}





