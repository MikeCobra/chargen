require_relative '../../lib/types/group'

RSpec.describe Group, "#handle" do
  before(:each) do
    @field_handler = double 'FieldHandler'
    allow(FieldHandler).to receive(:new).and_return(@field_handler)
    @group = Group.new
  end

  it "applies the field_handler and returns the result" do
    expect(@field_handler).to receive(:handle)
                              .with({'type' => 'options'})
                              .and_return('result')

    options = { 'test' => { 'type' => 'options' } }

    result = @group.handle(options)

    expect(result).to eq({ 'test' => 'result' })
  end
end
