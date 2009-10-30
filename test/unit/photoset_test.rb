require File.dirname(__FILE__) + '/../test_helper'

class Picto::PhotosetTest < ActiveSupport::TestCase
  context "A Photoset" do
    setup do
      @photoset = Factory(:photoset)
      2.times { @photoset.photos << Factory(:photo) }
    end

    should "be able to tell the number of photos it holds" do
      assert_equal(2, @photoset.number_of_photos)
    end
  end
end
