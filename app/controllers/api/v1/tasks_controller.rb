class Api::V1::TasksController < Api::V1::ApplicationController
  def index
    tasks = Task.
      ransack(ransack_params).
      result.includes(:author, :assignee).order(id: :desc).
      page(page).
      per(per_page)

    respond_with(tasks, each_serializer: TaskSerializer, root: 'items', meta: build_meta(tasks))
  end

  def show
    task = Task.find(params[:id])

    respond_with(task, serializer: TaskSerializer)
  end

  def create
    task = current_user.my_tasks.new(task_params)
    task.save

    respond_with(task, serializer: TaskSerializer, location: nil)
  end

  def update
    task = Task.find(params[:id])
    if params[:state_event]
      task.state_event = params[:state_event]
      task.save
    else
      task.update(task_params)
    end

    respond_with(task, serializer: TaskSerializer)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy

    respond_with(task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event, :expired_at)
  end
end
