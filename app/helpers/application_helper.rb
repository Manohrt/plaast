module ApplicationHelper
 def admin?
    if (User.find session[:user_id]).role =="Admin" 
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
 
 
end
