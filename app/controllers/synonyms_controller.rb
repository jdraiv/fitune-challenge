# frozen_string_literal: true

# Synonyms base controller
class SynonymsController < ApplicationController
  def create
    synonym = Synonyms::Assign.new(params[:word], params[:synonym]).call

    if synonym.error
      render json: synonym, status: :bad_request
    else
      render json: synonym
    end
  end
end
