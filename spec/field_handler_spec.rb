require_relative '../lib/field_handler'

require_relative '../lib/types/character'
require_relative '../lib/types/group'
require_relative '../lib/types/normal'
require_relative '../lib/types/value'
require_relative '../lib/types/weighted'

RSpec.describe FieldHandler, "#handle" do
  before(:each) do
    @character = double 'Character'
    allow(Character).to receive(:new).and_return(@character)

    @group = double 'Group'
    allow(Group).to receive(:new).and_return(@group)

    @normal = double 'Normal'
    allow(Normal).to receive(:new).and_return(@normal)

    @value = double 'Value'
    allow(Value).to receive(:new).and_return(@value)

    @weighted = double 'Weighted'
    allow(Weighted).to receive(:new).and_return(@weighted)

    @field_handler = FieldHandler.new
  end

  context "when a supported typed is given" do
    it "applies the correct handler to the field and return the result" do
      expect(@value).to receive(:handle)
                                .with('options')
                                .and_return('result')

      options = { 'value' => 'options' }

      result = @field_handler.handle(options)

      expect(result).to eq('result')
    end
  end

context "when an unsupported typed is given" do
  it "raises an error" do
    options = { 'not_a_type' => 'options' }

    expect {
      @field_handler.handle(options)
    }.to raise_error(RuntimeError)
  end
end
end
