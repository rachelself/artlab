class CreateArtistTags < ActiveRecord::Migration
  def change
    create_table :artist_tags do |t|
      t.belongs_to :user
      t.belongs_to :tag
      t.timestamps
    end
  end
end
