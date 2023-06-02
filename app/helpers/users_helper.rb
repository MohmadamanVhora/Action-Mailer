module UsersHelper
  def event_enrolled?(event)
    @user.events.include?(event)
  end
end
