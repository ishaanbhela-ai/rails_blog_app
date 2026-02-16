class PublishBlogJob < ApplicationJob
  queue_as :default
  def perform(blog_id)
    blog = Blog.find_by(id: blog_id)
    return unless blog

    PublishBlogService.new(blog).call
  end
end
