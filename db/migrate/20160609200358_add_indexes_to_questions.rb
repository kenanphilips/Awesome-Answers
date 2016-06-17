class AddIndexesToQuestions < ActiveRecord::Migration
  def change
    add_index :questions, :title, unique: true
    add_index :questions, :body
  end
end
