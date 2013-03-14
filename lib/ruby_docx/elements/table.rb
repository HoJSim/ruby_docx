# encoding: utf-8
class RubyDocx::Table < RubyDocx::Block
  protected
  def apply_style(properties_node, key, style)
    super
    case key
      when 'width'
        if style =~ /^(\d+)%$/
          property_node = Nokogiri::XML::Node.new 'tblW', properties_node.document
          property_node['w:w'] = $1.to_i * 50 # 1% == 50 pct
          property_node['w:type'] = 'pct'
          properties_node.add_child property_node
        end
      when 'border'
        border_size = style.split(' ').map(&:strip).find { |prop| prop =~ /^\d+(px)%/ }.to_i * 4
        border_style = 'single'
        border_color = 'auto'
        if border_size
          property_node = Nokogiri::XML::Node.new 'tblBorders', properties_node.document
          %w[top left bottom right insideH insideV].each do |border|
            border_node = Nokogiri::XML::Node.new border, properties_node.document
            border_node['w:val'] = border_style
            border_node['w:sz'] = border_size
            border_node['w:color'] = border_color
            border_node['w:space'] = 0
            property_node.add_child border_node
          end
          properties_node.add_child property_node
        end
    end
    properties_node
  end
end