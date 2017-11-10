class UserMailer < ApplicationMailer

  def invitation_email(user_membership, url, expiration_time)
    @user_membership = user_membership
    @url = url
    @expiration_time = expiration_time

    mail(to: @user_membership.invitation_email, subject: "You have been invited to use #{@user_membership.app.name}")
  end

end
