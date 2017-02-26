class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
    end

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

    can :manage, User do |u|
      u.id == user.id
    end
  end
end
