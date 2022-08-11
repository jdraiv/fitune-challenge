# frozen_string_literal: true

module Synonyms
  # Assigns a given synonym to a given word
  class Assign
    def initialize(word_value, synonym_value)
      @word_value = word_value
      @synonym_value = synonym_value
    end

    # Assigns a synonym for a given word
    def call
      return OpenStruct.new(error: 'Missing word or synonym value') if missing_params
      return OpenStruct.new(error: 'Synonym already exists') if synonym

      word.synonyms.create(value: format(@synonym_value))
      OpenStruct.new(message: 'Synonym has been created', data: { id: word.synonyms.last.id })
    rescue StandardError => e
      OpenStruct.new(error: e)
    end

    private

    def missing_params
      return true if @word_value.nil? || @synonym_value.nil?
    end

    def word
      @word ||= Word.find_or_create_by(value: format(@word_value))
    end

    def synonym
      Synonym.find_by_value(format(@synonym_value))
    end

    def format(value)
      value.downcase
    end
  end
end
