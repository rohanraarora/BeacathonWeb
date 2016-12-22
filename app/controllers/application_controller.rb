class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      if(token.nil? or token.empty?)
        return false
      end
      @current_user = User.find_by(token: token)
      if(@current_user.nil?)
        return_error_response(401,"Invalid token") and return false
      elsif(Date.today > @current_user.token_expiry_date)
        return_error_response(401,"Expired token") and return false
      else
        @current_user.token_expiry_date = Date.today + 60
        @current_user.save
        return true
      end
    end
  end

  def return_response(data, message, code, error)
    result = Hash.new
    if (data)
      result[:data] = Hash.new
      result[:data] = data
    end

    if (message)
      result[:message] = message
    end

    result[:code] = code
    result[:update] = need_app_update?()

    if (error)
      result[:error] = error
    end

    render json: result, status: code

  end

  def return_success_response(data,message)

    return_response(data,message,200,nil)

  end

  def return_error_response(code,error)

    return_response(nil,nil,code,error)

  end

  def return_missing_param(param)

    return_error_response(422,"Parameter " + param + " is missing.")

  end

  def need_app_update?
    return false
  end

  def throw_internal_error
    return_error_response(500,"Internal Server Error.")
  end


end
