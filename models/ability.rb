class MyAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, Course  do |course|
      course.enrollments.where(:role => :teacher).map(&:user_id).include?(user.id) if user
    end
    can :read, :all
  end
end