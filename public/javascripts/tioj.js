function tioj_prob_link(index){
	var url = "http://tioj.redirectme.net:8080/JudgeOnline/showproblem?problem_id=";
	return url + index.toString();
}
$(function(){
	$('#tioj a.prob_link').each(function(idx,el){
		el.href = tioj_prob_link($(el).html());
	})
})
