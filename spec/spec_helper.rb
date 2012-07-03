require File.dirname(__FILE__) + '/../lib/timl'

module Timl
  CASEDIR   = SPECDIR + '/case'
  RESULTDIR = SPECDIR + '/result'

  CASES     = Dir["#{CASEDIR}/*"].sort
  RESULTS   = Dir["#{RESULTDIR}/*"].sort

  # Zip cases and results together in an array of arrays.
  TESTPAIRS = CASES.zip(RESULTS)
end
