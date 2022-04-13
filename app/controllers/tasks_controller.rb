class TasksController < ApplicationController
     before_action :set_user, only: [:new, :create, :edit, :upadate, :index]
     before_action :logged_in_user, only: [:new, :create, :edit, :update, :index]

    def index
        @alltask = Task.all
        @tasks = Kaminari.paginate_array(@alltask).page(params[:page]).per(10)
    end
    
    def new
        @task = Task.new
    end
    
    def edit
        @task = Task.find(params[:task_id])
    end
    
    def show
        @task = Task.find(params[:task_id])
    end
    
    def create
        @task = Task.new(task_params)
        @task.user_id = @user.id
        if @task.save
            flash[:success] = 'タスク作成致しました。'
            redirect_to user_path
        else
            render :new
        end
    end
    
    def update
        @task = Task.find(params[:task_id])
        if @task.update_attributes(task_update_params)
            flash[:success] = "タスクを更新しました。"
        else
            flash[:danger] = "タスク更新に失敗しました。<br>" + @task.errors.full_messages.join("<br>")
            render :edit
        end
        redirect_to user_path
    end
    
    def update_total
        @task = Task.find(params[:task_id])
        task_new_total = @task.total.to_f + params[:total].to_f
        @task.total = task_new_total.to_f.floor(2)
        if @task.save
            flash[:success] = "タスクを更新しました。"
            redirect_to user_path
        else
            flash[:danger] = "タスク更新に失敗しました。"
            redirect_to user_path
        end
    end
    
    def destroy
        @task = Task.find(params[:task_id])
        @task.destroy
        flash[:success] = "タスクを削除しました。"
        redirect_to user_path
  end


    private

        def task_params
            params.permit(:name, :detail, :start_day, :finish_day)
        end
        
        def task_total_params
            params.permit(:name, :total)
        end
        
        def task_update_params
            params.require(:task).permit(:name, :detail, :start_day, :finish_day, :progress, :status, :total)
        end
end
