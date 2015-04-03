
// Display the selected band to the right of the bands list.


function showEventsForBands(){
	$("li.bandLi").click(function(e) {
		e.preventDefault();
		e.stopPropagation();    
		var bandId = $(this).attr("data-id");
		var fakeForm = {"band_id": bandId}
		var url = "bands/events";
		$.ajax(url, {
			method: "post",
			data: fakeForm,
			success: function(response) {
				replaceEvents(response);
			}
		});
	});
}
// Display the events or show a no upcoming shows notice
function replaceEvents(htmlResponse){
	if (htmlResponse.length > 0) {
		$(".event-list").html(htmlResponse);
	} else {
		$(".event-list").html("<li class=\"btn btn-default btn-lg disabled bandLi\"> No upcoming shows for that artist :(</li>");
	}
}