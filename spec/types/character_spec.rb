require_relative '../../lib/types/character'
require_relative '../../lib/types/group'

require 'json'

RSpec.describe Character, "#handle" do
  before(:each) do
    @group_handler = double 'Group'
    allow(Group).to receive(:new).and_return(@group_handler)
    @character = Character.new
  end

  context "when a template is given" do
    it "should use the template as a group" do
      template = {'thing' => { 'value' => 6}}
      expect(@group_handler).to receive(:handle).with(template)

      @character.handle({'template' => template})
    end
  end

  context "when a template_file is given" do
    it "should load the file as a template and use as a group" do
      template_file = 'test.json'
      template_file_contents = '{\'thing\' => { \'value\' => 5}}'
      template = {'thing' => { 'value' => 5}}
      file = double(File, read: template_file_contents)
      allow(File).to receive(:open).with(template_file, 'r').and_yield file

      allow(JSON).to receive(:parse).with(template_file_contents).and_return template

      expect(@group_handler).to receive(:handle).with(template)

      @character.handle({'template_file' => template_file})
    end
  end

  context "when a template and a template file is given" do
    it "should raise an error" do
      template = {'thing' => { 'value' => 6}}
      template_file = 'test.json'

      expect {
        @character.handle({'template' => template,
          'template_file' => template_file})
      }.to raise_error(RuntimeError)
    end
  end
end
