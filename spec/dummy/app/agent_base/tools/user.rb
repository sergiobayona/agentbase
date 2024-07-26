# frozen_string_literal: true

module AgentBase::Tools
  class User < Base

    # shows the user record from the database.
    # @param user_id [Integer] the id of the user to show.
    def show(user_id)
      @user = AgentBase::Models::User.find(user_id)
      render json: @user
    end

    # creates a new user record in the database.
    # @param user_params [Hash] the attributes of the user to create.
    def create(user_params)
      @user = User.new(user_params)
      if @user.save
        render json: @user, template: 'show'
      else
        render json: @user.errors
      end
    end
  end
end
