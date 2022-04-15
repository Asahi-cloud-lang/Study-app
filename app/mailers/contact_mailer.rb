class ContactMailer < ApplicationMailer

  def send_mail(user, task)
    @user = user
    @task = task
    mail( :to => @user.email,
          :subject => '【Study App】 お問い合わせありがとうございます' )
  end
end
