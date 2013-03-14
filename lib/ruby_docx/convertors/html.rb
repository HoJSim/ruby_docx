# encoding: utf-8
module RubyDocx::Convertor::Html
  require_relative 'elements/html/base'
  require_relative 'elements/html/paragraph'
  require_relative 'elements/html/header'
  require_relative 'elements/html/br'
  require_relative 'elements/html/span'
  require_relative 'elements/html/table'
  require_relative 'elements/html/tr'
  require_relative 'elements/html/td'
  require_relative 'elements/html/th'
  require_relative 'elements/html/hyperlink'

  ROUTES = {
      default: 'Paragraph',
      h1: 'Header',
      h2: 'Header',
      h3: 'Header',
      h4: 'Header',
      h5: 'Header',
      h6: 'Header',
      a: 'Hyperlink'
  }

  def self.convert(template, css_path = nil)
    css = self.load_styles(css_path)
    doc = RubyDocx::Document.new
    body = Nokogiri::HTML(template).xpath('//body').first
    body.children.each { |child| doc.append self.create_node(child, css) }
    doc
  end

  protected
  def self.create_node(tag, css)
    tag_name = tag.name.capitalize
    unless RubyDocx::Convertor::Html.const_defined? tag_name
      tag_name = ROUTES[tag.name.to_sym] || ROUTES[:default]
    end
    RubyDocx::Convertor::Html.const_get(tag_name).new(tag, css).build
  end

  ##
  # returns CssParser
  def self.load_styles(css_path = nil)
    default_css_path = File.expand_path("../../styles/default.css", __FILE__)
    css = CssParser::Parser.new
    css_block = File.read( default_css_path )
    css_block += File.read( css_path ) if css_path
    css.add_block!(css_block)
    css
  end
end