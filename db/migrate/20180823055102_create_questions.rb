class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :subject
      t.string :content
      t.integer :state
      t.references :user

      t.timestamps
    end
  end
end
