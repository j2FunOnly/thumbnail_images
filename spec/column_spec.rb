RSpec.describe ThumbnailImages::Column do
  describe 'should add images' do
    it 'should have initial zero size and height' do
      expect(subject.size).to eq(0)
      expect(subject.height).to eq(0)
    end

    it 'succefully' do
      filename = 'spec/fixtures/images/image001.jpg'
      image = ThumbnailImages::ImageFile.new(filename)
      subject.add image
      expect(subject.size).to eq(1)
      expect(subject.height).to eq(image.height)
    end
  end
end
