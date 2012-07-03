module Timl
  # Dynamically defines a tag method so we don't have to hit method_missing all
  # the time.
  def self.define_tags *args
    args.each do |tag|
      self.class.instance_eval do
        define_method tag do |*args, &block|
          @@out <<  "<#{tag.to_s}#{parameterize args.first}>"
          result = module_eval(&block)
          @@out <<  result unless result.nil? || result.start_with?('<')
          @@out <<  "</#{tag.to_s}>"
          @@out
        end
      end
    end
  end

  # Define tags to override existing methods that can mess with the DSL.
  define_tags :p

  # Start a Timl XML string. This is the main method for creating XML with Timl.
  # It accepts a format as its first parameter, which can either be :flat or
  # :pretty (defaults to :pretty). The :flat parameter gives you back XML that
  # has no indentation. The :pretty option runs the generated XML through the
  # REXML document formatter, which is a little slower but gives great
  # readability.
  #
  # Timl.start then takes a block, which kicks off the DSL. Here's a simple
  # example:
  #
  #   Timl.start :flat do
  #     p { "This is a paragraph." }
  #   end
  #
  #   #=> <p>This is a paragraph.</p>
  #
  # For more example please refer to the README.
  def self.start format = :pretty, &block
    @@out = ""
    module_eval &block
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
    define_tags name
    method(name).call args, &block
  end

  private

  def self.parameterize hash
    return "" unless hash.is_a? Hash
    hash.inject("") do |memo, entry|
      memo += " #{entry.first.to_s}=\"#{entry.last.to_s}\""
    end
  end

  # Appends:
  #
  #   <?xml version="1.0" encoding="UTF-8" ?>
  #
  # To the resulting XML file.
  def self.xml_header options = {}
    options[:version] = "1.0" unless options[:version]
    options[:encoding] = "UTF-8" unless options[:encoding]
    @@out << "<?xml #{parameterize(options)} ?>"
  end

  # Appends:
  #
  #   <!DOCTYPE html>
  #
  # To the resulting XML file.
  def self.html5_doctype
    @@out << '<!DOCTYPE html>'
  end
end
