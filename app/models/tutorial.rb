class Tutorial < ActiveRecord::Base
  acts_as_taggable_on :readers
  belongs_to :assign_item
end
