namespace :active_storage do
  desc "Purges unattached active storage blobs"
  task purge_unattached: :environment do
    ActiveStorage::Blob.unattached.where(active_storage_blobs: { created_at: ..2.days.ago }).find_each(&:purge_later)
  end
end
