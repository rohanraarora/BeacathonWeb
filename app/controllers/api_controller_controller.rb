class ApiControllerController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :authenticate_token, only: [:add_user_in_region, :remove_user_from_region,:update_user_in_regions,:logout]

  def sign_up

    email = params[:email]
    name = params[:name]
    profile_pic_url = params[:profile_pic_url]
    user = User.find_by_email(email)
    if user.nil?
      user = User.new(email: email, name: name)
      user.profile_pic_url = profile_pic_url;
    end
    if(user.token.nil? or user.token_expiry_date < Date.today)
      user.generate_token
    end
    user.save
    respond_to do |format|
      format.json{
        data = Hash.new
        data[:user] = user
        return_success_response(data,"Success")
      }
    end



  end

  def add_user_in_region

    region = Region.find_by_beacon_ssn(params[:beacon_ssn])
    user_region = UserRegionMapping.find_by_user_id_and_region_id(@current_user.id,region.id)
    if user_region.nil?
      user_region = UserRegionMapping.new
      user_region.user = @current_user
      user_region.region = region
      user_region.save
    end
    respond_to do |format|
      format.json{
        return_success_response(nil,"Success")
      }
    end

  end

  def update_user_in_regions
    regions_ssn = params[:list_beacon_ssn]
    @current_user.user_region_mappings.destroy_all
    regions_ssn.each do |region_beacon_ssn|
      region = Region.find_by_beacon_ssn(region_beacon_ssn)
      user_region = UserRegionMapping.new
      user_region.user = @current_user
      user_region.region = region
      user_region.save
    end

    respond_to do |format|
      format.json{
        return_success_response(nil,"Success")
      }
    end
  end


  def remove_user_from_region
    region = Region.find_by_beacon_ssn(params[:beacon_ssn])
    user_region = UserRegionMapping.find_by_user_id_and_region_id(@current_user.id,region.id)
    unless user_region.nil?
      user_region.destroy
    end
    respond_to do |format|
      format.json{
        return_success_response(nil,"Success")
      }
    end

  end

  def get_users_for_region
    region = Region.find_by_beacon_ssn(params[:beacon_ssn])
    unless region.nil?
      respond_to do |format|
        format.json{
          data = Hash.new
          data[:users] = region.users
          return_success_response(data,"Success")
        }
      end
    end
  end

  def get_users_regions
    @user_regions = UserRegionMapping.all
  end

  def logout
    @current_user.user_region_mappings.destroy_all
    respond_to do |format|
      format.json{
        return_success_response(nil,"Success")
      }
    end
  end

end
