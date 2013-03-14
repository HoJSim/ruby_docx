# encoding: utf-8
class RubyDocx::Convertor::Html::Table < RubyDocx::Convertor::Html::Base
  def convert
    node = RubyDocx::Table.new
    tag.children.each do |child|
      rows = if %w[thead tbody tfoot].include? child.name
        child.children
      elsif !child.is_a?(Nokogiri::XML::Text)
        [child]
      else
        []
      end
      rows.each do |row|
        node.append RubyDocx::Convertor::Html.create_node(row, css)
      end
    end
    node
  end
end