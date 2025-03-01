class RenamefeedbackableToFeedbackableOnFeedbacks < ActiveRecord::Migration[8.0]
  def change
    rename_column :feedbacks, :feedbackable_type, :feedbackable_type
    rename_column :feedbacks, :feedbackable_id, :feedbackable_id

    rename_index :feedbacks, "index_feedbacks_on_feedbackable", "index_feedbacks_on_feedbackable"
  end
end
