class HomeController < ApplicationController
  skip_before_filter :require_household
end