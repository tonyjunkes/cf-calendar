$(document).ready(function() {
  $("#view").click(function(a) {
		a.preventDefault();
		$("#dialog").dialog({
			show: 'fade',
			draggable: true,
			modal: true,
			height: 400,
			width: 500,
			resizable: false
		});
	});
});
