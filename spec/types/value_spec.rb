require_relative '../../lib/types/value'

RSpec.describe Value, "#handle" do
  before(:each) do
    @value = Value.new
  end

  it "returns the options" do
    result = @value.handle(12)
    expect(result).to eq 12
  end
end
