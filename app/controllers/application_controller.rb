#########################################################################################################
# Teem R41nB0WK4Tz is powered by:                                                                       #
#########################################################################################################
#                                                                                                       #
#                    `:oyhdmmdy+`                                                                       #  
#                `/hNMMNy+:--+mN+                                                                       #
#              .sNMMMm+`      .MM:                                          `+o.                        #
#            `sNMMMN+  `::     mMy                                          dMMd                .`      #
#   `-:.    :mMMMMh. `sNm`    .MMo                                         /MMM/             `/hMs      #
#  /mMMs  `sMMMMMs`./dMMh    .dMN.  `.:+ooo/-`           `.:/++/-`        `mMMy`           `/mMNo       #
#  +NMMs--dMMMMMNyhdhMMMMo:/smMN: .odNMMmNMMMd/       `:ymMMMMMNmmo`     `hNmMMh.         .hMMMo        #
#   -oydNMMMMMMmo/-` sMMMMMMMNh.`oNMMMh/.dMhoMM/     /dMMMNy/yMy.sMh`  `:dd:+MMMy        /NmsMM+        #
#      `dMMMMMM-      +dmmmdo- .hMMMd:   NM/ yMm    sMMMMy-  :MN-`NMo-odd+``mMMMh      `sNo``MMm`       #
#      oMMMMMMh         `.`   .mMMMd`    sMd-hMM../yMMMN/     :hmhNMNdy/` .dMMMM:     .dd-   dMMo       #
#     `NMMMMMM+              `mMMMN.     `+mNMMMddNMMMM+        .yMMo`   -mMMMMh     /Ny`    sMMN`      #
#     :MMMMMMM/             `hMMMMy        .NMMs..mMMMm         :NMN`   /NMMMMN.   `yNo..    oMMMo      #
#     /MMMMMMMh           .+mMMMMMo       `yMMm` oMMMMh        /NMMo   +MMMMMMo   /mM+-mh    +MMMm      #
#     :MMMMMMMMy-`    `-+hNMdMMMMMd`    `/mMMN-  dMMMMm`     .yMMMd`  +MMMMMMm` :hMN:.NMm`  `dMMMN`:sd: #
#      dMMMMMMMMNNdddmNNMMh:`mMMMMMms+oyNMMMm-   hMMMMMd/:-/yNMMMd`  .NMMMMMMMydMMd. oMMMmyymMMMMMNMNy  #
#      .dMMMMMMMMMMMMMMNs-   /MMMMMMMMMMMMMy.    +MMMMMMMMMMMMMMs`   /MMMMMMMMMMMo`  +MMMMMMMMMMNs:.`   #
#        +mMMMMMMMMMms:`      /NMMMMMMMMNy-       oMMMMMMMMMMNy.     `mMMMMMMMNy.    `yMMMMMMMMh.       #
#          ./osso+:`            :oyyyso:`          .+ydmmdho:`        `+yddhs/`        .+yhhyo-         #
#                                                                                                       #
#########################################################################################################

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :require_user
  before_filter :require_household
  before_filter :require_address
  helper_method :current_user_session, :current_user, :home_url_for
  before_filter :prepare_new_session

  def prepare_new_session
    @user_session = UserSession.new if current_user.blank?
  end

  # A simple route for the application home page or root_url.
  def show
    render
  end

  protected
  
    def home_url_for(user)
      return root_url if user.nil?
      user.is_admin? ? admin_root_url : members_root_url
    end

  private
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
      return @current_user_session
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
      return @current_user
    end
    
    def require_user
      unless current_user
        session[:original_uri] = request.request_uri
        flash[:error] = "You must log in."
        redirect_to login_url
        return false
      end
    end
     
    def require_no_user
      if current_user
        flash[:error] = "You must be logged out to access #{request.path}. <a href=\"/logout\">log out</a>?"
        redirect_to home_url_for(current_user)
        return false
      end
    end
     
    def require_household
      unless current_user.has_household? or current_user.household_confirmed.eql? 0
        flash[:error] = "You must create or join a household"
        redirect_to new_members_household_path
      end
    end
    
    def require_address
      if current_user.household.address.nil?
        flash[:error] = "You must have an address for your household."
        redirect_to new_members_address_path
      end
    end

end
