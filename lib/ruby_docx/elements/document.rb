# encoding: utf-8
class RubyDocx::Document
  TEMPLATE = 'document.xml'

  attr_accessor :children

  def initialize(children = [])
    @children = children
  end

  def append(block)
    @children << block
  end

  def prepend(block)
    @children.unshift block
  end

  def build
    doc = Nokogiri::XML(File.read( File.expand_path("../../templates/#{TEMPLATE}", __FILE__) ))
    body = doc.at '/w:document/w:body'
    @children.each { |child| body.add_child child.build }
    doc
  end

  def render
    build.to_s
  end

  def file
    file = Tempfile.new('order_preview')
    write_file(file)
  end

  def save(path)
    file = File.open(path, 'w')
    write_file(file).close
  end

  protected
  def write_file(file)
    zf = Zip::File.new File.expand_path("../../template.docx", __FILE__)
    buffer = Zip::OutputStream.write_buffer do |out|
      zf.entries.each do |e|
        if e.ftype == :directory
          out.put_next_entry(e.name)
        else
          out.put_next_entry(e.name)
          if e.name == "word/document.xml"
            out.write render
          else
            out.write e.get_input_stream.read
          end
        end
      end
    end
    file.write(buffer.string)
    file
  end
end