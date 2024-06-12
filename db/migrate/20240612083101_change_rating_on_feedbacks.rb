class ChangeRatingOnFeedbacks < ActiveRecord::Migration[7.1]
  def change
    change_column :feedbacks, :rating, :decimal
  end
end
