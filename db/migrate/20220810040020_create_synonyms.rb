class CreateSynonyms < ActiveRecord::Migration[6.0]
  def change
    create_table :synonyms do |t|
      t.references :word, null: false, foreign_key: true
      t.string :value
      t.boolean :authorized

      t.timestamps
    end
  end
end
