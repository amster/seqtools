require 'test_helper'

class SeqtoolsArraysTest < Test::Unit::TestCase
  context "empty?" do
    should "return true on empty arrays" do
      assert_equal true, Seqtools::Arrays::empty?(nil)
      assert_equal true, Seqtools::Arrays::empty?([])
    end
    should "return false on non-empty arrays" do
      assert_equal false, Seqtools::Arrays::empty?([1])
      assert_equal false, Seqtools::Arrays::empty?([nil])
    end
  end
  
  context "random_item" do
    should "return nil if input array is nil" do
      assert_nil Seqtools::Arrays::random_item(nil)
      assert_nil Seqtools::Arrays::random_item([])
    end
    should "return the first item if the array only has one item" do
      assert_equal :value, Seqtools::Arrays::random_item([:value])
    end
  end
  
  context "remove_blanks" do
    should "return a zero-length array" do
      ret = Seqtools::Arrays::remove_blanks(nil)
      assert_equal true, ret.is_a?(Array)
      assert_equal 0, ret.length

      ret = Seqtools::Arrays::remove_blanks([])
      assert_equal true, ret.is_a?(Array)
      assert_equal 0, ret.length
    end
    should "remove blank items" do
      assert_equal [], Seqtools::Arrays::remove_blanks([])
      assert_equal [], Seqtools::Arrays::remove_blanks([nil])
      assert_equal [], Seqtools::Arrays::remove_blanks([''])
      assert_equal [1], Seqtools::Arrays::remove_blanks([nil,1])
      assert_equal [1], Seqtools::Arrays::remove_blanks([1,nil])
      assert_equal [1,2], Seqtools::Arrays::remove_blanks([1,nil,2])
      assert_equal [1], Seqtools::Arrays::remove_blanks(['',1])
      assert_equal [1], Seqtools::Arrays::remove_blanks([1,''])
      assert_equal [1,2], Seqtools::Arrays::remove_blanks([1,'',2])
      assert_equal [1], Seqtools::Arrays::remove_blanks(['   ',1])
      assert_equal [1], Seqtools::Arrays::remove_blanks([1,'    '])
      assert_equal [1,2], Seqtools::Arrays::remove_blanks([1,'          ',2])
    end
  end
end
