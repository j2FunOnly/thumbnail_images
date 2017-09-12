RSpec.describe ThumbnailImages do
  describe 'version' do
    it 'should have version number' do
      # expect(described_class::VERSION).to exist
      should be_const_defined(:VERSION)
    end
  end
end
