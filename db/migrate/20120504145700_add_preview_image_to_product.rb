class AddPreviewImageToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cover_image, :binary
  end
end
