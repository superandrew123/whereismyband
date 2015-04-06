
$(function(){
	checkForDuplicate();
	//in event.js
	$("li.bandLi").on("click", showEventsForBands);
	$("li.bandLi").on("click", "a.bandDestroy", deleteBand);
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



// delete user band

function deleteBand(e) {
	if(e){
		e.preventDefault;
		var $li = $(this).parents("li");

		var id = $li.data("id")
		var data = {band_id: id}
	// delete request to bands controller destroy method
		$.ajax("/user_bands/", {
			"method": "DELETE",
			data: data,
			"complete": function() {
				$li.slideUp(function(r){
					$(".event-list").html("");
					$(this).remove();
				});
			}
		});
	}
}

// If no band conflicts, submit form
function submitBand(form) {
	var data = form.serialize();
	var url = form.attr("action");
	var method = form.attr("method");
	$.ajax(url, {
		method: method,
		data: data,
		success: function(response) {
			$('ul.band-list').prepend(response);
			$('.band-name').val("");
			$("li.bandLi").click(showEventsForBands);
			$("a.destroy").on("click", deleteBand);
			// showEventsForBands();
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





