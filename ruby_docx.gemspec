# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_docx/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby_docx"
  gem.version       = RubyDocx::VERSION
  gem.authors       = ["Dmitriy Mokrushin"]
  gem.email         = ["dimokr@ya.ru"]
  gem.description   = %q{Simple html to docx convertor}
  gem.summary       = %q{Simple html to docx convertor}
  gem.homepage      = "https://github.com/HoJSim/ruby_docx"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'nokogiri', '>= 1.5.5'
  gem.add_dependency 'css_parser'
  gem.add_dependency 'rubyzip', '>= 1.0.0'
end
