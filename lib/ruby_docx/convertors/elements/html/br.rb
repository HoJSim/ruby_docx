# encoding: utf-8
class RubyDocx::Convertor::Html::Br < RubyDocx::Convertor::Html::Base
  def convert
    RubyDocx::Br.new
  end
end