class TiojOjee < Ojee    
  def update_state
    require "open-uri"
    url = "http://tioj.redirectme.net:8080/JudgeOnline/userstatus?user_id="+self.name
    self[:problems_solved] = open(url).readlines.to_s.scan(%r{problem_id=\d+>(\d+)}).collect {|b| b[0]}
  end
end