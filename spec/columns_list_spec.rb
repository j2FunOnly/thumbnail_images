RSpec.describe ThumbnailImages::ColumnsList do
  # 640x640
  let(:image1_file) { 'spec/fixtures/images/image001.jpg' }
  let(:image1) { ThumbnailImages::ImageFile.new image1_file }

  # 1280x853
  let(:image2_file) { 'spec/fixtures/images/image002.jpg' }
  let(:image2) { ThumbnailImages::ImageFile.new(image2_file) }

  # 693x1280
  let(:image3_file) { 'spec/fixtures/images/image003.jpg' }
  let(:image3) { ThumbnailImages::ImageFile.new image3_file }

  let(:columns_count) { 2 }

  subject { described_class.new columns_count }

  describe '#initialize' do
    it 'should have declared columns count' do
      expect(subject.columns_count).to eq(columns_count)
    end

    it 'should have zero images' do
      expect(subject.size).to be_zero
    end
  end

  describe '#add' do
    it 'should add image to the one of the columns' do
      subject.add image1
      expect(subject.size).to eq(1)
    end

    it 'should add image to the column with minimal height' do
      subject.add image3
      subject.add image2
      subject.add image1
      expect(subject.size).to eq(3)
      expect(subject.columns[1].size).to eq(2)
    end
  end
end
