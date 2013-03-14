# encoding: utf-8
class RubyDocx::TableColumn < RubyDocx::Block
  protected
  def build_node
    node = super
    node.add_child RubyDocx::Paragraph.new(content, styles).build if content
    node
  end
end
