require 'rexml/document'

class Timl
  def self.start format = :pretty, &block
    @@out = ""
    class_eval &block
    case format
    when :pretty
      doc = REXML::Document.new(@@out)
      doc.write(xml = '', 2)
    when :flat
      xml = @@out
    else
    end

    @@out = ""
    xml
  end

  def self.method_missing name, *args, &block
    @@out <<  "<#{name}#{parameterize args.first}>"
    result = block_given? ? class_eval(&block) : ''
    @@out <<  result unless result.start_with? '<'
    @@out <<  "</#{name}>"
    @@out
  end

  private

  def self.parameterize hash
    return "" unless hash.is_a? Hash
    hash.inject("") do |memo, entry|
      memo += " #{entry.first.to_s}=\"#{entry.last.to_s}\""
    end
  end

  def self.xml_header
    @@out << '<?xml version="1.0" encoding="UTF-8" ?>'
  end
end


o = Timl.start do
  html do
    head do
      script src: "http://example.com"
    end

    div id: "test", class: "fake" do
      h1(class: "bold") { "Testing" }
      h2 { "Still testing" }
    end
  end
end

puts o
