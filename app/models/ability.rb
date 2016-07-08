class Ability
  include CanCan::Ability

  def initialize(user)
    # CanCanCan assumes that you have a method called 'current_user' which is available in the application controller. You don't have to explicitly create an Ability Object, this will be done automatically.

    # If 'current_user' is not nil, then it will use it. Otherwise, 'user' object will be set to a new 'User'.
    user ||= User.new

    # manage includes all actions such as edit, delete, create, read, etc...
    can :manage, Question do |q|
      q.user == user
    end

    can :destroy, Like do |l|
      l.user == user
    end

    if user.is_admin?
      # this means that if a user has the 'is_admin' field
      can :manage, :all
    else
      can :read, :all?
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
