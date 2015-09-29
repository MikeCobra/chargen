require 'json'
require_relative 'group'

class Character
  def initialize
    @group_handler = Group.new
  end

  def handle(options)
    template = options['template']
    template_file = options['template_file']

    if !template.nil? && !template_file.nil?
      fail 'Cannot use a template and and a template_file.'
    end

    if template.nil?
      template_string = File.open(template_file, 'r') do |file|
        file.read
      end
      template = JSON.parse(template_string)
    end

    @group_handler.handle(template)
  end
end
