require 'rails_helper'

RSpec.describe Gallery, :type => :model do
  it { should belong_to :user }
  it { should have_many :photos }
  it { should validate_presence_of :title }
end
