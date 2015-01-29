$(document).ready ->	
	$("input#pseudo").keyup (e)->		
		$("div[id^=rockstar-]").css("display", "block")
		cb1 = -> $("div[id^=rockstar-]").removeClass("hide")
		setTimeout cb1, 1000
		$("div:not([id^=rockstar-"+$("input#pseudo").val()+"])").addClass("hide")
		cb2 = -> $("[id^=rockstar-]:not([id^=rockstar-"+$("input#pseudo").val()+"])").css("display", "none")		
		setTimeout cb2, 1000
		return

	