function showEventsForBands(){
	$("li.bandLi").click(function() {    
		var bandId = $(this).attr("data-id");
		var fakeForm = {"band_id": bandId}
		var url = "bands/events";
		$.ajax(url, {
			method: "post",
			data: fakeForm,
			success: function(response) {
				debugger;
			}
		});
	});
}
