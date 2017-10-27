RSpec.describe ThumbnailImages do
  describe 'version' do
    it 'should have version number' do
      should be_const_defined(:VERSION)
    end
  end

  describe '#config' do
    let(:height) { 2 }
    let(:columns) { 3 }
    let(:list_height) { described_class::A4[:HEIGHT] * height }

    it 'should store configuration options' do
      described_class.configure do |c|
        c.columns = columns
        c.list_height = height
      end

      expect(described_class.config.columns).to eq(columns)
      expect(described_class.config.list_height).to eq(list_height)
    end
  end
end
