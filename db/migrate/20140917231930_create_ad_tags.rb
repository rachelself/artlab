class CreateAdTags < ActiveRecord::Migration
  def change
    create_table :ad_tags do |t|
      t.belongs_to :ad
      t.belongs_to :tag
      t.timestamps
    end
  end
end
