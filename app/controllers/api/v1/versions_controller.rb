module Api::V1
  class VersionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_model, only: [:index]

    # GET /api/versions
    # Required params: [:id, :type]
    def index
      if @model && @model.respond_to?(:versions)
        versions, meta = VersionsFetcher.new(@model.versions, params).fetch

        render json: versions, root: 'entities', meta: meta
      else
        render json: { status: false, errors: 'Cannot find target for revisions' }, status: :unprocessable_entity
      end
    end

    # PUT /api/versions/:id/revert
    def revert
      version =  PaperTrail::Version.find(params[:id])

      model_from_version = version.reify
      model_from_version.save!

      render json: version.next, root: 'entity'
    rescue Exception => e
      # TODO: LOG Error
      puts e.message
      render json: { status: false, errors: 'Something went wrong. Cannot revert to this version.' }, status: :unprocessable_entity
    end

    private

    def set_model
      type = params[:type]
      id = params[:id]

      if type && id
        model_class = type.classify.constantize
        @model = model_class.find(id)
      end

    rescue Exception => e
      # TODO: Log error
      puts e.message
      @model = nil
    end

  end
end