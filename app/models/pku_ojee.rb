class PkuOjee < Ojee    
  def update_state
    require "open-uri"
    url = "http://poj.org/userstatus?user_id="+self.name
    self[:problems_solved] = open(url).readlines.to_s.scan(%r{p\((\d+)\)}).collect{|b| b[0]}
  end
end