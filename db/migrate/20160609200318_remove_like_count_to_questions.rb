class RemoveLikeCountToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :like_count, :integer
  end
end
