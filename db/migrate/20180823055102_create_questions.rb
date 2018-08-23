class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :subject
      t.string :content
      t.integer :state
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
