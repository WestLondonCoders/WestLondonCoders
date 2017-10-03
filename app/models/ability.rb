class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :index, :all
      can :search, :all
      can [:join, :leave], Hackroom
      can :create, Comment
      # Users can manage their own accounts but not other people's
      can :manage, User, id: user.id
      # Users can manage their own posts but not other people's
      can :manage, Post, created_by_id: user.id
      # Users can manage hackrooms if they are an owner
      can :manage, Hackroom, owners: { id: user.id }
    end
  end
end
