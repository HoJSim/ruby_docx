# encoding: utf-8
class RubyDocx::Convertor::Html::Span < RubyDocx::Convertor::Html::Base
  def convert
    RubyDocx::Row.new(
        tag.children.select{|child| child.is_a? Nokogiri::XML::Text }.map(&:content).join(' '),
        {
            'white-space' => 'pre'
        }
    )
  end
end