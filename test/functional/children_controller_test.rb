require 'test_helper'

class ChildrenControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Child.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Child.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Child.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to child_url(assigns(:child))
  end

  def test_edit
    get :edit, :id => Child.first
    assert_template 'edit'
  end

  def test_update_invalid
    Child.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Child.first
    assert_template 'edit'
  end

  def test_update_valid
    Child.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Child.first
    assert_redirected_to child_url(assigns(:child))
  end

  def test_destroy
    child = Child.first
    delete :destroy, :id => child
    assert_redirected_to children_url
    assert !Child.exists?(child.id)
  end
end
