class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.references :user

      t.timestamps
    end
  end
end
