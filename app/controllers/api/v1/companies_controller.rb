module Api::V1
  class CompaniesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company

    # GET /api/companies
    def index
      companies, meta = Companies.all

      render json: companies, root: 'entities', meta: meta
    end

    # GET /api/companies/:uuid
    def show
      authorize @company

      render json: @company, root: 'entity'
    end

    # POST /api/companies
    def create
      company = Company.new(company_params)

      if company.save
        render json: company, root: 'entity'
      else
        render json: { status: false, errors: company.errors.full_messages }, status: :unprocessable_entity
      end

    end

    # PUT /api/companies/:uuid
    def update
      authorize @company

      if @company.update(company_params)
        render json: @company, root: 'entity'
      else
        render json: { status: false, errors: @company.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/companies/:id
    def destroy
      company = Company.find(params[:id])

      if company.destroy
        render json: company, root: 'entity'
      else
        render json: { status: false, errors: 'There was a problem with deleting the company' }, status: :unprocessable_entity
      end

    end


    private

    def set_company
      @company = Company.find_by(uuid: params[:id])
    end

    def company_params
      params.permit(:name, :address, :address2, :city, :state, :zip, :country)
    end
  end
end
