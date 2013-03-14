# encoding: utf-8
class RubyDocx::Convertor::Html::Td < RubyDocx::Convertor::Html::Base
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
    RubyDocx::TableColumn.new(nil, [], [node])
  end

  protected
  def apply_style(properties_node, key, style)
    super
    case key
      when 'vertical-align'
        property_node = Nokogiri::XML::Node.new 'vAlign', node.document
        property_node['w:val'] = style
        properties_node.add_child property_node
    end
    properties_node
  end
end
