class ImagesController < ApplicationController
  def attach_image
    task = Task.with_attached_image.find(params[:id])
    task_attach_image_form = TaskAttachImageForm.new(attachment_params)

    if task_attach_image_form.invalid?
      respond_with(task_attach_image_form)
      return
    end

    image = task_attach_image_form.processed_image
    task.image.attach(image)

    render(json: task, serializer: TaskSerializer)
  end

  def remove_image
    task = Task.with_attached_image.find(params[:id])
    task.image.purge

    render(json: task, serializer: TaskSerializer)
  end

  private

  def attachment_params
    params.require(:attachment).permit(:image, :crop_width, :crop_height, :crop_x, :crop_y)
  end
end
