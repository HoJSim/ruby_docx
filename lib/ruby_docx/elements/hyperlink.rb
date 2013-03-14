# encoding: utf-8
class RubyDocx::Hyperlink < RubyDocx::Block
  protected
  def build_node
    node = super
    node.at('/hyperlink/r/t').content = content
    node
  end
end