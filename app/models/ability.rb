class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :to => :read
    
    alias_action :new, :to => :create #which is clever because create will be triggered only new is..
    alias_action :edit, :to => :update
    alias_action :update, :destroy, :to => :modify
    # show index
    # edit -> _form.html -> update 
    # new -> _form.html -> create
    # destroy 
    
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    end   
    
    if user.is_oier?
      #About Assignment Handling
      can :read, Assignment
      can :create, Assignment 
      can :modify, Assignment, :setter => user.username
      can :read, AssignItem
      can :modify, AssignItem, :assignment => {:setter => user.username} 
    
      #About Code Handling
      can :read, Code
      can :see_source, Code, :oier_id => user.oier.id
      can :see_source, Code, :visibility => true
      can :modify, Code, :creator => user.oier.try(:name)
      can :create, Code

      can :all_tags, Code
      can :tags, Code
      # Managing his own Ojee items
      can :create, [TiojOjee, PkuOjee, UvaOjee, ZerojudgeOjee]
      can :modify, [TiojOjee, PkuOjee, UvaOjee, ZerojudgeOjee], :oier_id => user.oier.id
      can :update_stats, [TiojOjee, PkuOjee, UvaOjee, ZerojudgeOjee], :oier_id => user.oier.id
      can :hand_in, AssignItem do |item| 
        item.assignment.assigned_to.include?(user.oier)
      end
    end   
    
  end
end
