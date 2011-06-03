module OiersHelper
  def ojee_for(oier,ojtype)
    oier.ojees.find_by_type(Ojee::OJ_MAP[ojtype]) || Ojee.new()
  end
end
