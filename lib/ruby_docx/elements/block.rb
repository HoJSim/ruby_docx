# encoding: utf-8
class RubyDocx::Block < RubyDocx::InextensibleBlock
  attr_accessor :content, :children, :styles

  def initialize(content = nil, styles = {}, children = [])
    @content = content
    @children = children
    @styles = styles

    @template = 'block.xml'
  end

  def append(block)
    @children << block
  end

  def prepend(block)
    @children.unshift block
  end

  def build
    node = super
    apply_styles(node)
    @children.each { |child| node.add_child child.build }
    node
  end

  protected
  def apply_styles(node)
    if styles.present?
      properties_node = get_properties_node(node)
      styles.each do |key, style|
        apply_style(properties_node, key, style)
      end
    end
    node
  end

  def apply_style(properties_node, key, style)
    case key
      when 'text-align'
        property_node = Nokogiri::XML::Node.new 'jc', properties_node.document
        property_node['w:val'] = style
        properties_node.add_child property_node
      when 'font-weight'
        if style == 'bold' || (style =~ /^\d+$/ && style.to_i > 500 )
          properties_node.add_child Nokogiri::XML::Node.new 'b', properties_node.document
        end
      when 'font-size'
        property_node = Nokogiri::XML::Node.new 'sz', properties_node.document
        property_node['w:val'] = style.to_i * 2
        properties_node.add_child property_node

        property_node = Nokogiri::XML::Node.new 'szCs', properties_node.document
        property_node['w:val'] = style.to_i * 2
        properties_node.add_child property_node
    end
    properties_node
  end

  def get_properties_node(node)
    properties_node_name = "#{node.name}Pr"
    properties_node = node.children.find { |child| child.name == properties_node_name }
    return properties_node if properties_node
    properties_node = Nokogiri::XML::Node.new properties_node_name, node.document
    if node.children.empty?
      node.add_child(properties_node)
    else
      node.children.first.add_previous_sibling(properties_node)
    end
  end
end
