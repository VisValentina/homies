class StaticPagesController < ApplicationController
  def about
  end

  def invite
  	
  end

  def email_invite
  	InviteMailer.invite_user(current_user, params[:email]).deliver_now
  	redirect_to root_path, flash: {success: "#{params[:email]} has been invited!"}
  end
end
