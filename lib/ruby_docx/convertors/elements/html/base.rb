# encoding: utf-8
class RubyDocx::Convertor::Html::Base
  attr_reader :tag, :css
  def initialize(tag, css)
    @tag = tag
    @css = css
  end

  def build
    node = convert
    node.add_styles(styles) if styles.present?
    node
  end

  def convert
    RubyDocx::InextensibleBlock.new
  end

  def styles
    @styles = {}
    eval_styles.reverse.each do |row|
      prop, val = row.split(':', 2).map(&:strip)
      unless @styles.has_key? prop
        @styles[prop] = val.sub /;$/, ''
      end
    end
    @styles
  end

  protected
  def eval_styles
    styles = css[tag.name]
    tag.attributes.each do |_, attr|
      if attr.name == 'class'
        attr.value.split(' ').map(&:strip).each do |tag_class|
          styles += css[".#{tag_class}"]
        end
      elsif attr.name == 'id'
        styles += css["##{attr.value}"]
      end
    end
    styles.uniq.map { |row| row.split(';').map(&:strip) }.flatten
  end
end