require './models/printing'

  describe Printing do

    subject { Printing.new }

    context 'when initialized' do
      it 'contains an empty array for order information' do
        expect(subject.order_information).to eq([])
      end
    end
  end
