# frozen_string_literal: true

# Synonyms base controller
class SynonymsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_admin_user, only: [:update]

  def create
    synonym = Synonyms::Assign.new(params[:word], params[:synonym]).call

    if synonym.error
      render json: synonym, status: :bad_request
    else
      render json: synonym
    end
  end

  def update
    synonym = Synonym.update(params[:id], synonym_params)
    render json: synonym
  rescue StandardError => e
    render json: { error: e }, status: :bad_request
  end

  private

  def synonym_params
    params.require(:synonym).permit(:authorized)
  end
end
