require 'test_helper'

class ExamplesControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get examples_form_url
    assert_response :success
  end

end
