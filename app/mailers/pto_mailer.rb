class PtoMailer < ApplicationMailer

  def new_request(pto)
    @pto = pto
    @profile = @pto.user.profile
    @ptos_url = "#{ENV['GATEWAY_APP_URL']}/ptos"
    recipients = ['jeffrey.atto@concise.com', 'michael.schneider@concise.com']

    mail(to: recipients, subject: "PTO Request by #{@profile&.first_name}")
  end

  def pto_approved(pto)
    @pto = pto

    mail(to: @pto.user.email, subject: 'Your PTO request has been approved!')
  end

  def pto_rejected(pto)
    @pto = pto

    mail(to: @pto.user.email, subject: 'Your PTO request has been rejected!')
  end
end