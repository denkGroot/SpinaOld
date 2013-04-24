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
        can :manage, Spina::Inquiry

        Spina.plugins.each do |plugin|
          can :manage, "Spina::#{plugin.class_name}".constantize
        end
      end
    end
  end
end