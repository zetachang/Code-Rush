class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    end   
    
    #About Assignment Handling
    can :read, Assignment
    can :modify, Assignment, :setter => user.username
    can :manage, AssignItem, :assignment => {:setter => user.username} 

    if user.oier?
      can :manage, [Ojee, TiojOjee, UvaOjee, PkuOjee, ZerojudgeOjee], :oier_id => :oier_id
      can :hand_in, AssignItem do |item| 
        item.assignment.assigned_to.include?(user.oier)
      end
    end
   
  end
end
