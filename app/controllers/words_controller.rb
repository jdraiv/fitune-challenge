# frozen_string_literal: true

# Words controller
class WordsController < ApplicationController
  before_action :authenticate_user!
  def synonyms
    word = Words::SynonymsRetriever.new(params[:word]).call

    if word.error
      render json: word, status: :bad_request
    else
      render json: word.data
    end
  end
end
