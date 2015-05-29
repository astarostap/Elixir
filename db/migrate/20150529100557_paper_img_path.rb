class PaperImgPath < ActiveRecord::Migration
  def change
  	add_column :papers, :img_path, :text
  end
end
