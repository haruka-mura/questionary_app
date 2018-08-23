class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :comment
      t.references :user
      t.references :question

      t.timestamps
    end
  end
end
