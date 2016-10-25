require 'test_helper'

class Api::RealisersControllerTest < ActionController::TestCase

  setup do
    @appositive_payload = File.read(Rails.root.join("test/fixtures/appositive_payload.xml"))
    @a_problem_payload = File.read(Rails.root.join("test/fixtures/a_problem_payload.xml"))
  end

  test "realise appositive recording" do
    post :create, xml: @appositive_payload
    assert_response :success
    assert_equal assigns[:realisation], "An angioplasty balloon catheter, the D701000000992, was deployed."
  end

  test "realise a problem recording" do
    post :create, xml: @a_problem_payload
    assert_response :success
    assert_equal assigns[:realisation], "There is an eccentric, tubular stenosis in the third obtuse marginal branch.There is an 80 % stenosis in the proximal right coronary artery."
  end

end
