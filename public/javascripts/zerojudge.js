function zerojudge_prob_link(index,account){
	var url = "http://zerojudge.tw/RealtimeStatus?problemid=" + index + "&account=" + account;
	return url;
}
$(function(){
	$('#zerojudge a.prob_link').each(function(idx,el){
		el.href = zerojudge_prob_link($(el).html(),$('#zerojudge ul li').eq(0).html());
	})
})
