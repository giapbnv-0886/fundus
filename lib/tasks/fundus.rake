namespace :fundus do
  desc "Check purchase and remove it"
  task check_purchase: :environment do
    Donation.where(purchased_at: nil).delete_all
  end

end
