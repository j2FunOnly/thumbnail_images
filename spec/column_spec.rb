RSpec.describe ThumbnailImages::Column do
  let(:config) do
    config = instance_double('ThumbnailImages::Configuration')
    allow(config).to receive(:column_width).and_return(640)
    config
  end

  subject do
    described_class.new config.column_width
  end

  describe '#add_and_resize' do
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
      subject.add_and_resize image1_file

      expect(subject.size).to eq(1)
      expect(subject.height).to eq(image1.height)
    end

    it 'should calculate height of all added images' do
      subject.add_and_resize image1_file
      subject.add_and_resize image2_file

      total_heigth = image1.resize("#{config.column_width}x").height
      total_heigth += image2.resize("#{config.column_width}x").height

      expect(subject.size).to eq(2)
      expect(subject.height).to eq(total_heigth)
    end
  end
end
