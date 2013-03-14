# encoding: utf-8
class RubyDocx::Convertor::Html::Tr < RubyDocx::Convertor::Html::Base
  def convert
    node = RubyDocx::TableRow.new
    tag.children.each do |child|
      node.append(RubyDocx::Convertor::Html.create_node(child, css)) unless child.is_a?(Nokogiri::XML::Text)
    end
    node
  end
end