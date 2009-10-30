require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  context "A user" do
    setup do
      # at the end of the test round, the transation is not rolled back
      # and so users remain in the database
      User.all.each { |u| u.destroy }
      @user = Factory(:user)
      @first_photoset = Factory(:photoset, :owner => @user)
      @second_photoset = Factory(:photoset, :owner => @user)
      2.times { @first_photoset.photos << Factory(:photo) }
      1.times { @second_photoset.photos << Factory(:photo) }
    end
    should "be able to tell the total number of photos he has" do
      assert_equal(3, @user.number_of_photos)
    end

    should "update the total number when a new photo is added" do
      @second_photoset.photos << Factory(:photo)
      assert_equal(4, @user.number_of_photos)
    end
  end
end
