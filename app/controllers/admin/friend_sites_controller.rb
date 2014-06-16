class Admin::FriendSitesController < Admin::ApplicationController
  before_action :set_friend_site, only: [ :edit, :update, :destroy]
  def index
  	@friend_site = FriendSite.new
    @friend_sites = FriendSite.all 
  end

  def create
    FriendSite.create friend_site_params
  	redirect_to admin_friend_sites_path
  end

  def edit
  end

  def update
    @friend_site.update_attributes friend_site_params
    redirect_to admin_friend_sites_path
  end

  def destroy
    @friend_site.destroy
    redirect_to admin_friend_sites_path
  end

  private 
    def friend_site_params
    	params.require(:friend_site).permit(:name, :url)
    end
    def set_friend_site
      @friend_site = FriendSite.find(params[:id])
    end       
  end
