// function createBand(e){
//   e.preventDefault();
//   var $form = $(this);
//   var url = $form.attr("action");
//   debugger;
//   $.ajax(url, {
//   	method: "POST",
//   	data: $form.serialize(),
//   	success: function(response) {
//   		debugger;
//   		$("ul.band-list").prepend(response);
//   	}
//   });
//   // $.post(url, $form.serialize() , function(bandLi){
//   //   $(".band-name", $form).val("");
//   //   debugger;
//   //   $("ul.band-list").prepend(bandLI);
//   // });
// };

// $(function(){
//   $("form.new-band").on("submit", createBand);
// });
