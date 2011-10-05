class UserSession < Authlogic::Session::Base
  allow_http_basic_auth false
end
