# frozen_string_literal: true

module AgentBase::Tools
  class Company < Base
    def show(company_id)
      @user = Company.find(company_id)
      render json: @company
    end

    def create(company_params)
      @company = Company.new(company_params)
      if @company.save
        render json: @company
      else
        render json: @company.errors
      end
    end
  end
end
