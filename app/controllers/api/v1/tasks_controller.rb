class Api::V1::TasksController < Api::V1::ApplicationController
  def index
    tasks = Task.
      ransack(ransack_params).
      result.includes(:author, :assignee).
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

    SendTaskCreateNotificationJob.perform_async(task.id) if task.save

    respond_with(task, serializer: TaskSerializer, location: nil)
  end

  def update
    task = Task.find(params[:id])

    SendTaskUpdateNotificationJob.perform_async(task.id) if task.update(task_params)

    respond_with(task, serializer: TaskSerializer)
  end

  def destroy
    id = params[:id]
    task = Task.find(id)

    SendTaskDeleteNotificationJob.perform_async(current_user.id, id) if task.destroy

    respond_with(task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event, :expired_at)
  end
end
