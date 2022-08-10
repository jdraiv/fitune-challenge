# frozen_string_literal: true

module Words
  # Retrieves authorized synonyms for a given word
  class SynonymsRetriever
    def initialize(word_value)
      @word_value = word_value
    end

    def call
      return OpenStruct.new(error: 'Missing word') if missing_params
      return OpenStruct.new(error: "The given word doesn't exist") unless word

      OpenStruct.new(data: authorized_synonyms)
    rescue StandardError => e
      OpenStruct.new(error: e)
    end

    private

    def missing_params
      return true if @word_value.nil?
    end

    def word
      @word ||= Word.find_by_value(@word_value)
    end

    def authorized_synonyms
      @word.synonyms.select(&:authorized).pluck(:value)
    end
  end
end
