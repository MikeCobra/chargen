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

    template.nil? && template = resolve_file(template_file)

    @group_handler.handle(template)
  end

  private

  def resolve_file(file)
    template_string = File.open(file, 'r') do |f|
      f.read
    end
    JSON.parse(template_string)
  end
end
