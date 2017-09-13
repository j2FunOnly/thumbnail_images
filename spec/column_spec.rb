RSpec.describe ThumbnailImages::Column do
  describe '#add' do
    # 640x640
    let(:image1_file) { 'spec/fixtures/images/image001.jpg' }
    let(:image1) { MiniMagick::Image.open image1_file }

    # 1280x853
    let(:image2_file) { 'spec/fixtures/images/image002.jpg' }
    let(:image2) { MiniMagick::Image.open(image2_file) }

    it 'should have initial zero size and height' do
      expect(subject.size).to be_zero
      expect(subject.height).to be_zero
    end

    it 'should add image successfully' do
      subject.add image1_file

      expect(subject.size).to eq(1)
      expect(subject.height).to eq(image1.height)
    end

    it 'should calculate height of all added images' do
      total_heigth = image1.height + image2.height

      subject.add image1_file
      subject.add image2_file

      expect(subject.size).to eq(2)
      expect(subject.height).to eq(total_heigth)
    end
  end
end
