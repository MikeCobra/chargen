require_relative '../../lib/types/weighted'
require 'pickup'

RSpec.describe Weighted, "#handle" do
  before(:each) do
    @pickup = double 'Pickup'
    @weighted = Weighted.new
  end

  it "should set up the pickup and return the picked value" do
    options = { 'Option' => 100 }
    allow(Pickup).to receive(:new).with(options).and_return(@pickup)

    expect(@pickup).to receive(:pick).and_return('Option')

    result = @weighted.handle(options)

    expect(result).to eq 'Option'
  end
end
