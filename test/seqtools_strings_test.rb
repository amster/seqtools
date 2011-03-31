require 'test_helper'

class SeqtoolsStringsTest < Test::Unit::TestCase
  context "is_geocode?" do
    should "allow valid-looking geocodes" do
      assert_equal true, Seqtools::Strings::is_geocode?('37.754977,-122.446779')
      assert_equal true, Seqtools::Strings::is_geocode?('(37.754977,-122.446779)')
      assert_equal true, Seqtools::Strings::is_geocode?(' (   37.754977 , -122.446779 ) ')
      assert_equal true, Seqtools::Strings::is_geocode?(' (   37 , -122.446779 ) ')
    end
    should "disallow invvalid-looking geocodes" do
      assert_equal false, Seqtools::Strings::is_geocode?('37 . 754977,-122.446779')
      assert_equal false, Seqtools::Strings::is_geocode?('(37.754977,-122.446779')
      assert_equal false, Seqtools::Strings::is_geocode?('.754977,.446779')
      assert_equal false, Seqtools::Strings::is_geocode?('123 Main Street')
      assert_equal false, Seqtools::Strings::is_geocode?('37.754977 -122.446779')
    end
  end
end
