module UsersHelper
  def event_enrolled?(event)
    @user.events.ids.include?(event)
  end
end
