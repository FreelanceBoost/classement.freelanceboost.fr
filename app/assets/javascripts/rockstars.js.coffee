$(document).ready ->	
	$("input#pseudo").keyup (e)->		
		$("[id^=rockstar-]").removeClass("hide").css("display", "block")
		$(":not([id^=rockstar-"+$("input#pseudo").val()+"])").addClass("hide")
		callback = -> $("[id^=rockstar-]:not([id^=rockstar-"+$("input#pseudo").val()+"])").css("display", "none")		
		setTimeout callback, 500
		return

	