$(document).ready ->	
	$("input#pseudo").keyup (e)->		
		$("div:not([id^=rockstar-"+$("input#pseudo").val().replace('@', '')+"])").addClass("hide")
		if $("input#pseudo").val() == ""
			console.log("in condition")
			$("div[id^=rockstar-]").removeClass("hide")
		return

	