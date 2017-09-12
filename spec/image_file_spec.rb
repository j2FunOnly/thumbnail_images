RSpec.describe ThumbnailImages::ImageFile do
  let(:image_file) { 'spec/fixtures/images/image001.jpg' }
  subject { described_class.new image_file}

  it 'should have image filename' do
    expect(subject.filename).to eq(image_file)
  end

  it 'should have width' do
    expect(subject.width).to eq(640)
  end

  it 'should have height' do
    expect(subject.height).to eq(640)
  end
end
