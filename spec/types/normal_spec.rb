require_relative '../../lib/types/normal'
require 'simple-random'

RSpec.describe Normal, "#handle" do
  before(:each) do
    @random_generator = double("SimpleRandom")
    allow(@random_generator).to receive(:set_seed)
    allow(SimpleRandom).to receive(:new).and_return(@random_generator)
    @normal = Normal.new
  end

  it "returns a random value from the generator" do
    expect(@random_generator).to receive(:normal).with(100, 10).and_return(12)

    result = @normal.handle({'mean' => 100, 'std_dev' => 10})
    expect(result).to eq 12
  end

  context "with max set" do
    it "lowers the value if higher than max" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(12)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'max' => 10})
      expect(result).to eq 10
    end

    it "does not change the value if lower than max" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(13)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'max' => 15})
      expect(result).to eq 13
    end

    it "does not change the value if equal to max" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(15)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'max' => 15})
      expect(result).to eq 15
    end
  end

  context "with min set" do
    it "raises the value if lower than min" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(12)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'min' => 15})
      expect(result).to eq 15
    end

    it "does not change the value if higher than min" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(15)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'min' => 9})
      expect(result).to eq 15
    end

    it "does not change the value if equal to min" do
      expect(@random_generator).to receive(:normal).with(100, 10).and_return(15)

      result = @normal.handle({'mean' => 100, 'std_dev' => 10, 'min' => 15})
      expect(result).to eq 15
    end
  end

  context "with both min and max set" do
    it "errors when max lower than min" do
      expect {
        @normal.handle({'mean' => 100, 'std_dev' => 10, 'min' => 15, 'max' => 14})
      }.to raise_error(RuntimeError)
    end
  end
end
