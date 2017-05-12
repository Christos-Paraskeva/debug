require './models/material'

describe Material do

  before(:each) do
    @material = Material.new('WNP/SWCL001/010')
  end

  context 'is initialized with' do
    it 'an identifier' do
      expect(@material.identifier).to eq('WNP/SWCL001/010')
    end
  end
end
