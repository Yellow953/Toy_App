class RelationshipsController < ApplicationController
    before_action :logged_in_user

    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        flash[:sucess] = "You followed this user now"
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end

    def destroy
        user = Relationship.find(params[:id]).followed
        current_user.unfollow(user)
        flash[:danger] = "You unfollowed this user now"
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
    
end