module CodesHelper
  include ActsAsTaggableOn::TagsHelper
  
  def visibility_to_human(visibility)
    if visibility == true
      return "Public"
    else
      return "Private"
    end
  end
end
