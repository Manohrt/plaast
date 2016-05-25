class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 before_action :check_session
 def check_session
  if session[:user_id].blank?
   redirect_to root_path
  end
 end
   
 # def current_order
   # Order.find session[:order_no] if !session[:order_no].blank?
 # end

=begin def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
=end  end

 def admin?
    if (User.find session[:user_id]).role == "Admin"
       true
    end
  end

  def operator?
    if (User.find session[:user_id]).role == "Operator"
       true
    end
  end
 def factory?
    if (User.find session[:user_id]).role == "Factory"
       true
    end
  end
  
  # def order?
   #  if (@order_summary = OrderSummary.only_deleted.find params[:id])
   # @order_summary.really_destroy!
   #  end
  # end
end

