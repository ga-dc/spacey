class Ability
  include CanCan::Ability

  def initialize(user)
    can :approve, Event do |event|
      user.is_admin
    end
  end
end
