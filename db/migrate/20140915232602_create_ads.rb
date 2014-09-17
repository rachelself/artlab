class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :project_photo
      t.boolean :local_only
      t.references :user

      t.timestamps
    end
  end
end
