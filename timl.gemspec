require File.dirname(__FILE__) + '/lib/timl'

Gem::Specification.new do |s|
  s.name = %q{timl}
  s.version = Timl::VERSION
  s.authors = ["Sam Rose"]
  s.email = %q{samwho@lbak.co.uk}
  s.summary = %q{A Tiny XML building library, akin to builder.}
  s.homepage = %q{http://github.com/samwho/timl}
  s.description = %q{Similar to builder, Timl provides a DSL for creating XML.}
  s.required_ruby_version = '>= 1.9.2'
  s.license = 'MIT'

  # Add all files in git to the files parameter.
  s.files = `git ls-files`.split /\n/
end
