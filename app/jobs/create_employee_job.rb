class CreateEmployeeJob < ApplicationJob
  queue_as :default
  
  def perform(user_id)
    user = User.find(user_id)
    user.create_employee!(name: user.name)
  end
end
