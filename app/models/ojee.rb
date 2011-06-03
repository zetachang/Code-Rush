class Ojee < ActiveRecord::Base 
  belongs_to :oier
  serialize :problems_solved
  validates_presence_of :name,:ojtype
  OJ_TYPES = ['TIOJ','UVa','PKU','ZeroJudge']
  OJ_MAP ={'TIOJ' => 'TiojOjee', 'UVa' => 'UvaOjee', 'PKU' => 'Pkuojee', 'ZeroJudge' => 'ZerojudgeOjee'}
  def problems_solved
    self[:problems_solved] || random_problem
  end
  
  def solved_count
    problems_solved.length
  end
  
  private
  
  def random_problem
    (1001..rand(100)+1001).to_a.collect{|a| a.to_s}
  end 
end


