require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    Fabricate(:user)
  end

  it { should have_many :galleries }
  it { should have_many(:photos).through(:galleries) }
  it { should have_many :ads }
  it { should have_many :artist_tags }
  it { should have_many(:tags).through(:artist_tags) }
  it { should accept_nested_attributes_for(:artist_tags) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
end
