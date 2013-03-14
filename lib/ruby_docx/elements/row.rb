# encoding: utf-8
class RubyDocx::Row < RubyDocx::Block
  protected
  def build_node
    node = super
    t_node = node.at('/r/t')
    t_node.content = content
    if styles['white-space'] == 'pre'
      t_node['xml:space'] = 'preserve'
    end
    node
  end
end
