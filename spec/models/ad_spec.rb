require 'rails_helper'

RSpec.describe Ad, :type => :model do
  it { should belong_to :user }
  it { should have_many :ad_tags }
  it { should have_many(:tags).through(:ad_tags) }
  it { should accept_nested_attributes_for(:ad_tags) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
