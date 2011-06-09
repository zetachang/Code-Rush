//URL = 'http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=24&page=show_problem&problem=';
URL = "http://uva.onlinejudge.org/external/";
function get_category(str){
	tmp = "";
	for(var i=0;i<str.length-2;i++)
	{
		tmp += str[i];
	}
	return tmp;
}
function uva_prob_link(el){
	id = $(el).html();
	url = URL + get_category(id) + "/" + id + '.html';
	el.href = url;
	el.target = "_blank";
}
$(function(){
	$('#uva a.prob_link').each(function(idx,el){
		uva_prob_link(el);
	});
})
