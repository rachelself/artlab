describe ProfileImageUploader do
  include CarrierWave::Test::Matchers

  before do
    @user = Fabricate(:user)
    ProfileImageUploader.enable_processing = true
    @uploader = ProfileImageUploader.new(@user, :profile_image)
    file = File.open('spec/support/data/example_profile_image.png')
    @uploader.store!(file)
  end

  after do
    ProfileImageUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumbnail' do
    it 'should scale down to 200x200' do
      @uploader.thumb.should have_dimensions(200, 200)
    end
  end

  context 'the small thumbnail' do
    it 'should scale down to 60x60' do
      @uploader.small_thumb.should have_dimensions(60, 60)
    end
  end
end
