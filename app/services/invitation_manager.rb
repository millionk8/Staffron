class InvitationManager

  def initialize(user_membership)
    @user_membership = user_membership
  end

  def invite
    now = Time.current
    expiration_time = now + 2.days
    url  = "http://saffron.local/invitation?invitation_token=#{@user_membership.invitation_token}"

    UserMailer.invitation_email(@user_membership, url, expiration_time.to_s).deliver_later

    @user_membership.update!(invitation_sent_at: now, invitation_expires_at: expiration_time)

  rescue Exception => e
    puts e.message
    false
  end

end