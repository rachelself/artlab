require 'rails_helper'

RSpec.describe AdTag, :type => :model do
  it { should validate_presence_of :ad_id }
  it { should validate_presence_of :tag_id }
end
