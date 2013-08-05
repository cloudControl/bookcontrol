class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    send(@user.role, user)
  end

  def editor user
    can :manage, Book
    can :read, user
    can :manage, user, :id => user.id
    can [:create, :update], Reservation
  end

  def admin user
    can :manage, :all
  end
end
