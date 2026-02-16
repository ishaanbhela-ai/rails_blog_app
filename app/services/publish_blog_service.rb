class PublishBlogService
  def initialize(blog)
    @blog = blog
  end
  def call
    return false if @blog.published?

    @blog.update(published: true)
    # Any other side effects (sending emails, etc.) would go here
  end
end
