class RemoveTypeOfFromFeedbacks < ActiveRecord::Migration[7.1]
  def change
    remove_column :feedbacks, :type_of
  end
end
