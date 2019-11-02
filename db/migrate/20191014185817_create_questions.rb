class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :subject, foreign_key: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
