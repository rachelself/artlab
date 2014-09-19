require 'rails_helper'

RSpec.describe Tag, :type => :model do
  it { should have_many :artist_tags }
  it { should have_many(:users).through(:artist_tags) }
  it { should have_many :ad_tags }
  it { should have_many(:ads).through(:ad_tags) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
