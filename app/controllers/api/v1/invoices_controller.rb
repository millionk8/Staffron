module Api::V1
	class InvoicesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_invoice, except: [:index, :create]

    # GET /api/invoices
    def index
      invoices, meta = InvoicesFetcher.new(Invoice.where(company: current_company), params).fetch

      render json: invoices, root: 'entities', meta: meta
    end

    # GET /api/invoices/:id
    def show
      authorize @invoice

      render json: @invoice, root: 'entity'
    end

    # POST /api/invoices
    def create
      authorize Invoice

      invoice = Invoice.new(invoice_params)
      invoice.company_id = current_user.company.id
      if invoice.save
        render json: invoice, root: 'entity'
      else
        render json: { status: false, errors: invoice.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/invoices/:id
    def update
      authorize @invoice

      if @invoice.update(invoice_params)
        render json: @invoice, root: 'entity'
      else
        render json: { status: false, errors: @invoice.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/invoices/:id
    def destroy
      authorize @invoice

      if @invoice.destroy
        render json: @invoice, root: 'entity'
      else
        render json: { status: false, message: 'There was a problem while deleting the invoice' }, status: :unprocessable_entity
      end
    end

    private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.permit(:type, :app_id, :name, :status)
    end
	end
end