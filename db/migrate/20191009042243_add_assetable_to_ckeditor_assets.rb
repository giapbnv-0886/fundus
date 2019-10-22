class AddAssetableToCkeditorAssets < ActiveRecord::Migration[5.2]
  def self.up
    change_table :ckeditor_assets do |t|
      t.integer :assetable_id
      t.string  :assetable_type, limit: 30
    end
    add_index :ckeditor_assets, [:assetable_type, :type, :assetable_id], name: :idx_ckeditor_assetable_type
    add_index :ckeditor_assets, [:assetable_type, :assetable_id], name: :idx_ckeditor_assetable
  end
end
