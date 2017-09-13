RSpec.describe ThumbnailImages::Configuration do
  describe 'default configuration' do
    let(:default_columns) { 4 }
    let(:default_height) { ThumbnailImages::A4[:HEIGHT] * 3 }
    let(:default_column_width) { ThumbnailImages::A4[:WIDTH] / default_columns }

    it 'should have 4 columns' do
      expect(subject.columns).to eq(default_columns)
    end

    it 'should have list height as triple A4' do
      expect(subject.list_height).to eq(default_height)
    end

    it 'should have column width' do
      expect(subject.column_width).to eq(default_column_width)
    end
  end
end
