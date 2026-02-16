class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.published
    respond_to do |format|
      format.html
      format.json { render json: BlogSerializer.render(@blogs) }
    end
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: BlogSerializer.render(@blog) }
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        PublishBlogJob.set(wait: 1.hour).perform_later(@blog.id)
        format.html { redirect_to @blog, notice: "Blog created. Will publish in 1 hour." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "Blog was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def publish
    @blog = Blog.find(params[:id])
    if PublishBlogService.new(@blog).call
      redirect_to @blog, notice: "Blog published!"
    else
      redirect_to @blog, alert: "Blog is already published or failed to publish."
    end
  end

  def unpublished
    @blogs = Blog.unpublished
    respond_to do |format|
      format.html { render :index }
      format.json { render json: BlogSerializer.render(@blogs) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.expect(blog: [ :title, :body ])
    end
end
