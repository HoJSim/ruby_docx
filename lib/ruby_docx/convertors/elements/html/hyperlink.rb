# encoding: utf-8
class RubyDocx::Convertor::Html::Hyperlink < RubyDocx::Convertor::Html::Base
  def convert
    RubyDocx::Hyperlink.new(tag['href'])
  end
end