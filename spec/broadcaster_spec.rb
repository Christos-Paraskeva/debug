require './models/broadcaster'

describe Broadcaster do

  before(:each) do
    @broadcaster = Broadcaster.new(1, :test)
  end

  context 'when initialized' do
    it 'has an id' do
      expect(@broadcaster.id).to eq(1)
    end

    it 'has a name' do
      expect(@broadcaster.name).to eq(:test)
    end
  end
end
