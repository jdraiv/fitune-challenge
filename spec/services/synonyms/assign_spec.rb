# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synonyms::Assign do
  describe '#call' do
    context 'when no params are given' do
      it 'returns an error' do
        result = described_class.new(nil, nil).call
        expect(result.error).to be_a(String)
      end
    end

    context 'when a non existing word and synonym is given' do
      it 'creates a new word and synonym' do
        expect { described_class.new('good', 'neat').call }.to change(Word, :count).by(1).and(change(Synonym, :count).by(1))
      end
    end

    context 'when an existing word is given, and a non existing synonym is given' do
      before do
        create(:word)
      end
      it 'creates a new synonym and assigns it to existing word' do
        expect { described_class.new('good', 'excellent').call }.not_to change { Word.count }.from(1)
      end
    end
  end
end
