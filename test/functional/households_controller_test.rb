require 'test_helper'

class HouseholdsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Household.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Household.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Household.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to household_url(assigns(:household))
  end

  def test_edit
    get :edit, :id => Household.first
    assert_template 'edit'
  end

  def test_update_invalid
    Household.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Household.first
    assert_template 'edit'
  end

  def test_update_valid
    Household.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Household.first
    assert_redirected_to household_url(assigns(:household))
  end

  def test_destroy
    household = Household.first
    delete :destroy, :id => household
    assert_redirected_to households_url
    assert !Household.exists?(household.id)
  end
end
