# encoding: utf-8
class RubyDocx::Paragraph < RubyDocx::Block
  def build
    # doc = RubyDocx::Convertor::Html.convert(nil); puts doc.render
    # doc = RubyDocx::Convertor::Html.convert(nil); doc.save('/Users/Homer/Temp/creating.docx')
    set = []
    node = build_node
    apply_styles node
    set << node
    @children.each do |child|
      if child.is_a?(self.class)
        child_set = child.build
        unless child_set.all? { |cnode| cnode.name == 'p' && cnode.children.empty? }
          child_set.each { |item| set << item }
        end
      elsif child.is_a?(RubyDocx::Table)
        set << child.build
      elsif (child.is_a?(RubyDocx::Row) || child.is_a?(RubyDocx::Br) || child.is_a?(RubyDocx::Hyperlink)) && set.size > 1
        RubyDocx::Paragraph.new(nil, styles, [child]).build.each { |item| set << item }
      else
        node.add_child child.build
      end
    end
    delete_empty_nodes set
    node_set = Nokogiri::XML::NodeSet.new( document || Nokogiri::XML::Document.new )
    set.each { |item| node_set << item }
    node_set
  end

  protected
  ##
  # removes empty node (<p/>) and convert <p><r><cr/></r></p> to <p><r/></p> that excess break lines are exluded
  def delete_empty_nodes(set)
    set.reject! { |node| node.name == 'p' && node.children.empty? }
    set.select do |node|
      node.name == 'p' &&
          node.children.size == 1 &&
          node.children.first.name == 'r' &&
          node.children.first.children.size == 1 &&
          node.children.first.children.first.name == 'cr'
    end.each do |node|
      node.children.first.children.remove
    end
  end

  def build_node
    node = super
    if content
      rows = content.split("\n")
      rows.each_with_index do |row, row_number|
        node.add_child RubyDocx::Row.create(row)
        if row_number != rows.size - 1
          node.add_child RubyDocx::Br.create
        end
      end
    end
    node
  end
end