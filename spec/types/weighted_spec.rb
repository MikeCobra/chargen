require_relative '../../lib/types/weighted'
require 'pickup'

RSpec.describe Weighted, "#handle" do
  it "should set up the pickup and return the picked value" do
    pickup = double 'Pickup'
    options = { 'Option' => 100 }
    allow(Pickup).to receive(:new).with(options).and_return(pickup)
    weighted = Weighted.new

    expect(pickup).to receive(:pick).and_return('Option')

    result = weighted.handle(options)

    expect(result).to eq 'Option'
  end
end
