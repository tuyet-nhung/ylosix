require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    login_admin

    get :index
    assert_response :success
  end

end