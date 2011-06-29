module AssignmentsHelper
  def gen_class_list(assign)
    list = []
    list << (assign.due? ? 'due' : 'not-due')
    return list
  end
end
