class RubyDocx::Convertor::Html::Header < RubyDocx::Convertor::Html::Base
  def convert
    default_styles = {
        'font-weight' => 'bold',
        'font-size' => (20 - tag.name.gsub(/\D/, '').to_i)
    }
    node = RubyDocx::Paragraph.new(nil, default_styles)
    tag.children.each do |child|
      if child.is_a?(Nokogiri::XML::Text) && child.content.present?
        node.append(RubyDocx::Row.new(child.content, default_styles))
      end
    end
    node
  end
end