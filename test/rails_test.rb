require "minitest/autorun"
require "autotest/rails"

class RailsTest < MiniTest::Unit::TestCase
  describe Autotest::Rails do
    before do
      @at = Autotest::Rails.new
    end
    
    describe "#path_to_classname" do
      it "should convert paths to classnames" do
        assert_equal "PostControllerTest", @at.path_to_classname("test/controllers/post_controller_test.rb")
        assert_equal "PostCellTest", @at.path_to_classname("test/cells/post_cell_test.rb")
      end
    
      it "should convert namespaces, too" do
        assert_equal "Blogging::PostControllerTest", @at.path_to_classname("test/controllers/blogging/post_controller_test.rb")
      end
    end
  end
end
