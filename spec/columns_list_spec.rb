RSpec.describe ThumbnailImages::ColumnsList do
  # 640x640
  let(:image1_file) { 'spec/fixtures/images/image001.jpg' }

  # 1280x853
  let(:image2_file) { 'spec/fixtures/images/image002.jpg' }

  # 693x1280
  let(:image3_file) { 'spec/fixtures/images/image003.jpg' }

  let(:config) { ThumbnailImages::Configuration.new.tap { |c| c.columns = 2 } }

  subject { described_class.new config }

  describe '#initialize' do
    it 'should have declared columns count' do
      expect(subject.columns_count).to eq(config.columns)
    end

    it 'should have zero images' do
      expect(subject.size).to be_zero
    end
  end

  describe '#add' do
    it 'should add image to the one of the columns' do
      subject.add image1_file
      expect(subject.size).to eq(1)
    end

    it 'should add image to the column with minimal height' do
      subject.add image3_file
      subject.add image2_file
      subject.add image1_file

      expect(subject.size).to eq(3)
      expect(subject.columns[1].size).to eq(2)
    end
  end
end
