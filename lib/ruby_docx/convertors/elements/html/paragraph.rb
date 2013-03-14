# encoding: utf-8
class RubyDocx::Convertor::Html::Paragraph < RubyDocx::Convertor::Html::Base
  def convert
    node = RubyDocx::Paragraph.new
    tag.children.each do |child|
      child_node = if child.is_a?(Nokogiri::XML::Text)
        RubyDocx::Row.new(child.content) if child.content.present?
      else
        RubyDocx::Convertor::Html.create_node(child, css)
      end
      node.append(child_node) if child_node
    end
    node
  end
end