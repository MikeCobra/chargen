require 'json'
require_relative 'group'

class Character
  def initialize
    @group_handler = Group.new
  end

  def handle(options)
    template = options.fetch 'template' {fail 'Template not found'}
    template_file = options.fetch 'template_file' {fail 'Template file not found'}

    fail 'Cannot use a template and and a template_file.' unless template.nil? || template_file.nil?

    template ||= resolve_file(template_file)

    @group_handler.handle template
  end

  private

  def resolve_file(file)
    JSON.parse( File.open(file, 'r') {  |f| f.read  }  )
  end
end
