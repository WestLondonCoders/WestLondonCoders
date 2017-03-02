class Ability
  include CanCan::Ability

  def initialize(user)
    # Admins can do everything, all users can see everything

    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
    end

    # Roles

    if user.has_role? :editor
      can :manage, Post
    else
      can :read, Post
    end

    if user.has_role? :moderator
      can :manage, Comment
    else
      can :read, Comment
    end

    if user.has_role? :organiser
      can :manage, Event
    end

    # Custom abilities

    # Users can manage their own accounts but not other people's
    can :manage, User, id: user.id

    # Users can manage their own posts but not other people's
    can :manage, Post, created_by: user.id

    # Users can manage hackrooms if they are an owner
    can :manage, Hackroom, owners: { id: user.id }
  end
end
