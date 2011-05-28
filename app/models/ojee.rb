class Ojee < ActiveRecord::Base
  belongs_to :oier
  validates_presence_of :name,:ojtype
  def solved_problem
    return problem = ['1001','1002']
    require "open-uri"
    url = "http://tioj.redirectme.net:8080/JudgeOnline/userstatus?user_id="+self.name
    problem = open(url).readlines.to_s.scan(%r{problem_id=\d+>(\d+)}) 
  end
end
