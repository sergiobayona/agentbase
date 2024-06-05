# frozen_string_literal: true

module AgentBase::Tools
  class UserTools < Base
    def show(user_id)
      @user = AgentBase::Models::User.find(user_id)
      render json: @user
    end

    def create(user_params)
      @user = User.new(user_params)
      if @user.save
        render json: @user, template: 'show'
      else
        render json: @user.errors
      end
    end

    # Instructions.for(:show).(params: [{ user_id:, desc: 'The id of the user' }])
  end
end
