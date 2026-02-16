require 'rails_helper'
RSpec.describe Blog, type: :model do
  it "is valid with valid attributes" do
    blog = Blog.new(title: "Hello", body: "World")
    expect(blog).to be_valid
  end
  it "is invalid without a title" do
    blog = Blog.new(title: nil)
    expect(blog).to_not be_valid
  end
  describe "scopes" do
    it "returns published blogs" do
      published = Blog.create(title: "P", body: "B", published: true)
      unpublished = Blog.create(title: "U", body: "B", published: false)
      expect(Blog.published).to include(published)
      expect(Blog.published).to_not include(unpublished)
    end
  end
end
