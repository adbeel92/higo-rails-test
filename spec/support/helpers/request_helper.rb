# frozen_string_literal: true

module RequestHelper
  def authenticated_user
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end

  def current_user
    @current_user ||= find_or_create_by(
      :user, email: 'test1@test.com'
    )
  end

  def another_current_user
    @another_current_user ||= find_or_create_by(
      :user, email: 'test2@test.com'
    )
  end

  def find_or_create_by(reference, attributes)
    reference.to_s.camelize.constantize
             .find_by(attributes) || create(reference, attributes)
  end
end
