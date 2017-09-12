RSpec.describe ThumbnailImages::ImageFile do
  subject { described_class.new 'spec/fixtures/images/image001.jpg'}

  it 'should have width' do
    expect(subject.width).to eq(640)
  end

  it 'should have height' do
    expect(subject.height).to eq(640)
  end
end
