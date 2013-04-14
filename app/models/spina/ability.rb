module Spina
  class Ability
    include CanCan::Ability

    def initialize(user)
      if user.admin?
        can :manage, :all
      else
        can :manage, Spina::Page
        can :manage, Spina::Photo
        can :manage, Spina::Account
        # can :manage, Inquiry
      end
    end
  end
end