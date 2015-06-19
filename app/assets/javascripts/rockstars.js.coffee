$(document).ready ->
	$("input#pseudo").keyup (e)->
		$("div:not([id^=rockstar-"+$("input#pseudo").val().replace('@', '')+"])").addClass("hide")
		if $("input#pseudo").val() == ""
			console.log("in condition")
			$("div[id^=rockstar-]").removeClass("hide")
		return

FreelanceBoostRanking = {}

FreelanceBoostRanking.onDocumentReady = (callback) ->
  $(document).ready(callback)
  $(document).on('page:load', callback)

FreelanceBoostRanking.load_sumome_script = (data_sumo_site_id) ->
  sumo = document.createElement("script")
  sumo.type = "text/javascript"
  sumo.async = true
  sumo.src = "//load.sumome.com/"
  sumo.setAttribute('data-sumo-site-id', data_sumo_site_id)
  (document.getElementsByTagName("head")[0] or document.getElementsByTagName("body")[0]).appendChild sumo

FreelanceBoostRanking.onDocumentReady ->
  FreelanceBoostRanking.load_sumome_script("a4ccc88e31ec75718c5f2c7b96eab0b33bcd4282adc1caff6dcdd81ba61f4595")
  $("img").lazyload()

