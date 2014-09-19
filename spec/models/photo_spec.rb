require 'rails_helper'

RSpec.describe Photo, :type => :model do
  it { should belong_to :gallery }
  it { should validate_presence_of(:image).
      with_message(/must upload at least one photo/) }
  it { should validate_presence_of(:gallery_id).
      with_message(/must choose a gallery/) }
end
