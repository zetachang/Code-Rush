class Ojee < ActiveRecord::Base 
  belongs_to :oier
  serialize :problems_solved
  validates_presence_of :name
  validate :ojee_should_not_be_duplicated
  attr_protected :ojtype
  OJ_TYPES = ['TIOJ', 'UVa', 'PKU', 'ZeroJudge']
  TYPES = ['TiojOjee', 'UvaOjee', 'PkuOjee', 'ZerojudgeOjee']
  OJ_MAP ={'TIOJ' => 'TiojOjee', 'UVa' => 'UvaOjee',
           'PKU' => 'PkuOjee', 'ZeroJudge' => 'ZerojudgeOjee'}
  
  def ojee_should_not_be_duplicated
    if self.oier.ojees.find_by_ojtype(self.ojtype)
      errors.add(:ojtype,"should not be duplicated.")
    end
  end
  
  def problems_solved
    self[:problems_solved] || []
  end
  
  def solved_count
    problems_solved.length
  end
  
  def to_param
    self.ojtype
  end
  private
  
  def random_problem
    (1001..rand(100)+1001).to_a.collect{|a| a.to_s}
  end 
end


