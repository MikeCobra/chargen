require_relative '../../lib/types/value'

RSpec.describe Value, "#handle" do
  it "returns the options" do
    value = Value.new
    result = value.handle(12)
    expect(result).to eq 12
  end
end
