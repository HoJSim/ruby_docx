# encoding: utf-8
class RubyDocx::InextensibleBlock
  attr_accessor :document, :styles
  def build
    build_node
  end

  def add_styles(adding_styles)
    self.styles = ( styles.present? ? styles : {} ).merge(adding_styles)
  end

  def self.create(*args)
    new(*args).build
  end

  protected
  def template
    "#{self.class.to_s.split('::').last.underscore}.xml"
  end

  def build_node
    Nokogiri::XML(File.read( File.expand_path("../../templates/#{template}", __FILE__) )).children.last
  end
end
