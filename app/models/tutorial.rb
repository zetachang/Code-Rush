class Tutorial < ActiveRecord::Base
  acts_as_taggable_on :readers
  acts_as_commentable
  belongs_to :assign_item
end
