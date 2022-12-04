require "test_helper"

class AppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app = apps(:one)
  end

  test "should get index" do
    get apps_url, as: :json
    assert_response :success
  end

  test "should create app" do
    assert_difference("App.count") do
      post apps_url, params: { app: { name: @app.name } }, as: :json
    end

    assert_response :created
  end

  test "should show app" do
    get app_url(@app), as: :json
    assert_response :success
  end

  test "should update app" do
    patch app_url(@app), params: { app: { name: @app.name } }, as: :json
    assert_response :success
  end

  test "should destroy app" do
    assert_difference("App.count", -1) do
      delete app_url(@app), as: :json
    end

    assert_response :no_content
  end
end
