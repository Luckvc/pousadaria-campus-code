class AddAnswerToReview < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :answer, :text
  end
end
