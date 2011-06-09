function pku_prob_link(index){
	var url = "http://poj.org/problem?id=";
	return url + index.toString();
}
$(function(){
	$('#pku a.prob_link').each(function(idx,el){
		el.href = pku_prob_link($(el).html());
	})
})
