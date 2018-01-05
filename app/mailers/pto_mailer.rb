class PtoMailer < ApplicationMailer

  def pto_approved(pto)
    @pto = pto

    mail(to: @pto.user.email, subject: 'Your PTO request has been approved!')
  end

  def pto_rejected(pto)
    @pto = pto

    mail(to: @pto.user.email, subject: 'Your PTO request has been rejected!')
  end

end
