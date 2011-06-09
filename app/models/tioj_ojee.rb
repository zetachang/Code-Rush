class TiojOjee < Ojee    
  URL = "http://tioj.redirectme.net:8080/JudgeOnline/userstatus?user_id=<name>"
  def update_stat
    require "open-uri"
    url = URL.sub(/<name>/,self.name)
    begin
      raw_html = open(url).readlines.to_s
    rescue
      return false
    end
    reqexp = %r{problem_id=\d+>(\d+)}
    self[:problems_solved] = raw_html.scan(reqexp).collect {|b| b[0]}
    return true
  end
end