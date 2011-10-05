require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Address.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Address.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Address.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to address_url(assigns(:address))
  end

  def test_edit
    get :edit, :id => Address.first
    assert_template 'edit'
  end

  def test_update_invalid
    Address.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Address.first
    assert_template 'edit'
  end

  def test_update_valid
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Address.first
    assert_redirected_to address_url(assigns(:address))
  end

  def test_destroy
    address = Address.first
    delete :destroy, :id => address
    assert_redirected_to addresses_url
    assert !Address.exists?(address.id)
  end
end
