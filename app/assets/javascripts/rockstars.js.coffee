$(document).ready ->	
	$("input#pseudo").keyup (e)->
		cb1 = -> $("div[id^=rockstar-]").removeClass("hide").css("display", "block")
		setTimeout cb1, 1000
		$("div:not([id^=rockstar-"+$("input#pseudo").val()+"])").addClass("hide")
		cb2 = -> $("[id^=rockstar-]:not([id^=rockstar-"+$("input#pseudo").val()+"])").css("display", "none")		
		setTimeout cb2, 1000
		return

	