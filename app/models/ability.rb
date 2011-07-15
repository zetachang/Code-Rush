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
    
    #About Assignment Handling
    can :read, Assignment
    can :create, Assignment 
    can :modify, Assignment, :setter => user.username
    can :manage, AssignItem, :assignment => {:setter => user.username} 
    
    #About Code Handling
    can :read, Code
    can :modify, Code, :creator => user.oier.try(:name)
    #can :creat_comment, Code
    if user.is_oier?
      # Create his own code snippet
      can :create, Code
      can :all_tags, Code
      # Managing his own Ojee items
      can :manage, [Ojee, TiojOjee, UvaOjee, PkuOjee, ZerojudgeOjee], :oier_id => :oier_id
      can :hand_in, AssignItem do |item| 
        item.assignment.assigned_to.include?(user.oier)
      end
    end
   
  end
end
