class AssignedShip < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :oier
end