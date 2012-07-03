libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

module Timl
  VERSION   = '0.2'
  ROOTDIR   = File.expand_path(File.dirname(__FILE__) + '/..')
  SPECDIR   = ROOTDIR + '/spec'
end

require 'rexml/document'
require 'timl/timl'
