class AddPreviewImageToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cover_image, :binary, :limit => 1.megabyte
  end
end
