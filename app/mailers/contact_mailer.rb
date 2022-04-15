class ContactMailer < ApplicationMailer

  def send_mail(user, task)
    @user = user
    @task = task
    mail( :to => @user.email,
          :subject => '【Study App】 ご利用頂きありがとうございます' )
  end
end
