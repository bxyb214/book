require 'test_helper'

class NodeFeedsControllerTest < ActionController::TestCase
  setup do
    @node_feed = node_feeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_feed" do
    assert_difference('NodeFeed.count') do
      post :create, node_feed: {  }
    end

    assert_redirected_to node_feed_path(assigns(:node_feed))
  end

  test "should show node_feed" do
    get :show, id: @node_feed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_feed
    assert_response :success
  end

  test "should update node_feed" do
    patch :update, id: @node_feed, node_feed: {  }
    assert_redirected_to node_feed_path(assigns(:node_feed))
  end

  test "should destroy node_feed" do
    assert_difference('NodeFeed.count', -1) do
      delete :destroy, id: @node_feed
    end

    assert_redirected_to node_feeds_path
  end
end
