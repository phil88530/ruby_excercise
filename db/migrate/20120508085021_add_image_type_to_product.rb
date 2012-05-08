class AddImageTypeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cover_image_type, :string
  end
end
