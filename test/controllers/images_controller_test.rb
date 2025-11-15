require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test 'should put attach_image' do
    author = create(:user)
    task = create(:task, author: author)

    image = file_fixture('image.jpg')
    attachment_params = {
      image: fixture_file_upload(image, 'image/jpeg'),
      crop_x: 190,
      crop_y: 100,
      crop_width: 300,
      crop_height: 300,
    }

    put :attach_image, params: { id: task.id, attachment: attachment_params, format: :json }
    assert_response :success

    task.reload
    assert task.image.attached?

    data = JSON.parse(response.body)
    assert data.dig('task', 'image_url') == AttachmentsService.file_url(task.image)
  end

  test 'should put remove_image' do
    author = create(:user)
    task = create(:task, author: author)

    image = file_fixture('image.jpg')
    attachable_image = fixture_file_upload(image)

    task.image.attach(attachable_image)

    put :remove_image, params: { id: task.id, format: :json }
    assert_response :success

    task.reload
    refute task.image.attached?
  end
end
