class ProfilesController < ApplicationController
    before_action :set_user, only: %i[show edit update]
    
    def show; end
    
    def edit; end
    
    def update
        if @user.update(user_params)
            redirect_to profile_path(@user)
        else
            render :edit
        end
    end
    
    private
    
    def set_user
        @user = User.find(current_user.id)
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :avatar, :play_video, :profile, :avatar_cache, :play_video_cache)
    end
end
