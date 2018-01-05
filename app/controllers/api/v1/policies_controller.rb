module Api::V1
  class PoliciesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_policy

    # GET /api/policy
    def show
      render json: @policy, root: 'entity'
    end

    # POST /api/policy/
    def create
      authorize Policy

      policy = Policy.new(policy_params)
      policy.company = current_user.company

      if policy.save
        render json: policy, root: 'entity'
      else
        render json: { status: false, errors: policy.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/policy/
    def update
      authorize @policy

      if @policy.update(policy_params)
        render json: @policy, root: 'entity'
      else
        render json: { status: false, errors: @policy.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/policy/accept
    def accept
      authorize @policy

      if current_user.update(policy_accepted_at: Time.current)
        render json: current_user, root: 'entity'
      else
        render json: { status: false, errors: @policy.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def policy_params
      params.permit(:text)
    end

    def set_policy
      @policy = Policy.find_by(company_id: current_user.company)
    end

  end
end
