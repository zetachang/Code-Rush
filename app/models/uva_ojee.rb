class UvaOjee < Ojee
  validates_presence_of :userid
  URL = 'http://uhunt.felix-halim.net/api/subs/<userid>'
  def update_stats
    require "open-uri"
    url = URL.sub(/<userid>/,self[:userid].to_s)
    begin
      json = ActiveSupport::JSON.decode(open(url).readlines.to_s)
      str = json['subs']
    rescue
      return false
    end    
    subs = str.scan(%r{\[\d+,(\d+),(\d+),\d+,\d+,\d+,\d+,-?\d+\],?}) #sort{|a,b|a.to_i <=> b.to_i}
    probs = subs.select{|p| p[1] == '90'}.collect{|p| p[0]}.uniq 
    make_table
    self[:problems_solved] = probs.collect{|p| @problem_table[p] }
    return true
  end
  
  #protected
  def make_table
    require "open-uri"
    url = "http://uhunt.felix-halim.net/api/p"
    @problem_table = {}
    ActiveSupport::JSON.decode(open(url).readlines.to_s).each do |e|
      @problem_table[e[0].to_s] = e[1].to_s
    end
  end
end