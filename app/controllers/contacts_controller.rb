class ContactsController < ApplicationController
  
  def sending
    @task = Task.find(params[:task_id])
    @user = User.find(params[:id])
    if @task.valid?
      ContactMailer.send_mail(@user, @task).deliver
      flash[:success] = 'メール送信しました。'
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
end

