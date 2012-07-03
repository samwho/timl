module Timl
  # Dynamically defines a tag method so we don't have to hit method_missing all
  # the time.
  def self.define_tags *args
    args.each do |tag|
      self.class.instance_eval do
        define_method tag do |*args, &block|
          @@out ||= ""
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

  def self.xml_header
    @@out << '<?xml version="1.0" encoding="UTF-8" ?>'
  end
end
