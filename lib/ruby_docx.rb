# encoding: utf-8
require "nokogiri"
require "css_parser"
require "zip"
require "ruby_docx/version"

module RubyDocx
	class InvalidOperation < StandardError; end

  require 'ruby_docx/elements/document'
  require 'ruby_docx/elements/inextensible_block'
  require 'ruby_docx/elements/block'
  require 'ruby_docx/elements/paragraph'
  require 'ruby_docx/elements/row'
  require 'ruby_docx/elements/br'
  require 'ruby_docx/elements/table'
  require 'ruby_docx/elements/table_row'
  require 'ruby_docx/elements/table_column'
  require 'ruby_docx/elements/hyperlink'

  module Convertor
    require 'ruby_docx/convertors/html'
  end
end
