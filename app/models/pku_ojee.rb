class PkuOjee < Ojee    
  URL = "http://poj.org/userstatus?user_id=<name>"
  def update_stats
    #return true
    require "open-uri"
    url = URL.sub(/<name>/,self.name)
    begin
      raw_html = open(url).readlines.to_s
    rescue
      return false
    end
    reqexp = %r{p\((\d+)\)};
    self.problems_solved = raw_html.scan(reqexp).collect{|b| b[0]}
    return true
  end
end