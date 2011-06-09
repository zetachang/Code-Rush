class ZerojudgeOjee < Ojee
  URL = 'http://zerojudge.tw/ShowUserStatistic?account=<name>'
  
  def update_stat
    require "open-uri"
    url = URL.sub(/<name>/,self[:name])
    begin
      raw_html = open(url).readlines.to_s
    rescue
      return false
    end
    reqexp = %r{/RealtimeStatus\?problemid=(\w\d+).+"acstyle"}
    self[:problems_solved] = raw_html.scan(reqexp).collect {|p| p[0]}
    return true
  end
end